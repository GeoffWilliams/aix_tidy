# Aix_tidy::Ftp
#
# Install and configure FTP with minor hardening
#
# @param package_source path to bos.msg.en_US.net.tcp.client package file if
#   installation is needed
# @param banner_message Banner message to set
class aix_tidy::ftp(
    $package_source  = undef,
    $banner_message  = false,
) {

  $ftp_users = "/etc/ftpusers"

  # Ban root from using ftp
  file { $ftp_users:
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0644",
  }
  file_line { "/etc/ftpusers root":
    ensure  => present,
    path    => $ftp_users,
    line    => "root",
    require => File[$ftp_users],
  }

  # set FTP umask
  chsubserver { "ftp->tcp":
    params => "ftpd -l -u077",
  }

  # make sure FTP software installed
  package { "bos.msg.en_US.net.tcp.client":
    ensure => present,
    source => $package_source,
  }

  if $banner_message {
    # Set a login banner

    # Login banner for FTP on AIX is get/set using dspcat - seems to be an early
    # way of performing localisation on AIX - strings are externalised as templated
    # messages that are user modifiable using the dspcat program.  Unfortunately
    # everything in dspcat is referenced to an ID number.  Fortunately, ID numbers
    # seem to be consistent between major releases (tested AIX 6.1 and 7.1)
    $sect = "1"
    $key = "9"
    $catalogue = "/usr/lib/nls/msg/en_US/ftpd.cat"
    $temp_catalogue = "/tmp/ftpd.tmp"

    # dspcat lets us examine a catalogue section/key but we must always reload a
    # complete catalogue file if changes are needed.
    $awk_script =
"awk -F'\t' '{ if (\$1 == \"${key}\")
  print \$1 \"\t\" \"\\\"${banner_message}\\\"\"
else
  print
}' "
    $script = "dspcat -g ${catalogue} | ${awk_script} > ${temp_catalogue} &&
gencat ${catalogue} ${temp_catalogue} && rm ${temp_catalogue}"

    exec { "dspcat ftp key=${key}":
      command => $script,
      unless  => "dspcat ${catalogue} ${sect} ${key} | grep '${banner_message}'",
      path    => ['/usr/bin', '/bin'],
    }
  }

}
