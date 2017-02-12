# Aix_tidy::Snmp
#
# Manage snmpd.conf settings:
# * disable private, public and system communities
# * Ensure all remaining communities are read only
# * Ensure all remaining communities are restricted to ip range
#
# @param ip_range IP address range (network+subnet) to restrict all remaining
#   community entries to
class aix_tidy::snmp(
    $ip_range = "192.168.1.0 255.255.255.0",
) {
  $snmpd_conf = "/etc/snmpd.conf"
  $snmpd_tmp = "${snmpd_conf}.tmp"
  $replace_snmpd_conf = "> ${snmpd_tmp} && mv ${snmpd_tmp} ${snmpd_conf} && chgrp system ${snmpd_conf} && chmod 0640 ${snmpd_conf}"

  file { $snmpd_conf:
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0640",
  }

  # disable all entries in private, system or public communities
  ["private", "system", "public"].each |$community| {
    $comment_community =
      "awk '{
        if (match(\$0, /^community.*${community}/)) {
          print \"#\" \$0
        } else {
          print \$0
        }
      }' ${snmpd_conf} ${replace_snmpd_conf}"

    # disable community string
    exec { "/etc/snmpd.conf community ${community}":
      command => $comment_community,
      onlyif  => "grep ^community.*${community} ${snmpd_conf}",
      path    => ['/usr/bin', '/bin/']
    }
  }

  # Convert readWrite to readOnly
  $fix_rw =
    "awk '{
      if (match(\$0, /^community.*readWrite/)) {
        gsub(/readWrite/,\"readOnly\",\$0)
        print \$0
      } else {
        print \$0
      }
    }' ${snmpd_conf} ${replace_snmpd_conf}"

  exec { "/etc/snmpd.conf fix readWrite community":
    command => $fix_rw,
    onlyif  => "grep '^community.*readWrite' ${snmpd_conf}",
    path    => ["/usr/bin", "/bin"],
  }

  if $ip_range {
    # force all community entries to be restricted to IP address
    # very slack regexp matching for IP addres + subnet
    $ip_re = '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
    $net_re = "${ip_re}\\s+${ip_re}"
    $net_re_grep = "${ip_re}[[:space:]]+${ip_re}"
    $fix_ip =
      "awk '{
        if (match(\$0, /^community/)) {
          if (match(\$0, /${net_re}/)) {
            print \$0
          } else {
            print \$1 \" \" \$2 \" \" \"${ip_range}\" \" \" \$3 \" \" \$4
          }
        } else {
          print \$0
        }
      }' ${snmpd_conf} ${replace_snmpd_conf}"

    exec { "/etc/snmpd.conf fix missing IP address community":
      command => $fix_ip,
      onlyif  => "grep '^community' ${snmpd_conf} | grep -E -v '${net_re_grep}'",
      path    => ["/usr/bin", "/bin"],
    }
  }
}
