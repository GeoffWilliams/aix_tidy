# Aix_tidy::Nfs_options
#
# Make sure NFS filesystems are mounted correctly
# * enforce specific set of options for all mounts
# * remove all instances of localhost and $fqdn from the exports file
#
# @param options Options force these options to exist for every NFS mount in its
#   /etc/filesystems entry
# @param default_root_squash Value to set root_squash to if the entry is missing
#   or not allowed
# @param default_authentication Value to set sec to if entry is missing or
#   invalid
# @param allowed_root_squash_re Quoted regular expression matching allowed
#   values for the root_squash option
# @param allowed_security_methods_re Quoted regular expression matching allowed
#   values for the sec option
# @param manage_nfs_mounts True to enfoce the NFS mount options in
#   /etc/filesystems else do nothing
# @param manage_local_alias True to remove localhost and its aliases from the
#   allow option else do nothing
# @param manage_missing_access True to disable any entries that do not contain
#   an access option otherwise do nothing
# @param manage_root_squash True to fix any entries that are missing the
#   root_squash option otherwise do nothing
# @param manage_security True to fix any entries that are missing the sec option
#   otherwise do nothing
class aix_tidy::nfs_options(
  String  $options                      = "rw,bg,hard,intr,nosuid,sec=sys",
  String  $default_root_squash          = "-2",
  String  $default_authentication       = "sys",
  String  $allowed_root_squash_re       = "-2|-1",
  String  $allowed_security_methods_re  = "sys|dh|krb5|krb5p",
  Boolean $manage_nfs_mounts            = true,
  Boolean $manage_local_alias           = true,
  Boolean $manage_missing_access        = true,
  Boolean $manage_root_squash           = true,
  Boolean $manage_security              = true,
) {

  $exports = "/etc/exports"
  $replace_exports = " > ${exports}.tmp && mv ${exports}.tmp ${exports} && chgrp system ${exports}"

  if $manage_nfs_mounts {
    $nfs_mounts = dig($facts, 'mountpoints').then | $mountpoints | {
      $mountpoints.filter |$index, $values| {
        $values['filesystem'] =~ "nfs"
      }.map |$index, $value| {
        $index
      }
    }

    # enforce correct options for all nfs mounts
    if $nfs_mounts {
      mount { $nfs_mounts:
        options => $options,
      }
    }
  }
  # Ensure we have an exports file to work on...
  file { $exports:
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0644",
  }

  if $manage_local_alias {
    # remove all instances of 'localhost' and $fqdn from access= attribute in
    # /etc/exports - can't do this with augeas since AIX has its own whacked
    # exports format (sigh)
    $local_names_re = "(localhost|${facts['fqdn']}|${facts['hostname']})"
    $remove_localhost_alias =
  "awk '{
  if (match(\$0, /[^#].*access.*${$local_names_re}:?*/))
  	gsub(/${local_names_re}:?/, \"\", \$0);
  print \$0
  }' ${exports} ${replace_exports}"

    exec { "${exports} disable localhost alias":
      command => $remove_localhost_alias,
      onlyif  => "grep -E  '^[^#].*access=.*${local_names_re}.*' ${exports}",
      path    => [ '/usr/bin', '/bin'],
      notify  => Exec["exportfs"],
      require => File[$exports]
    }
  }

  if $manage_missing_access {
    # disable all hosts entries lines without explicit access rules
    $comment_no_access =
  "awk '{ if (match(\$0, /[^#].*access=.*/))
  	print \$0
  else
  	print \"#\" \$0
  }' ${exports} ${replace_exports}"

    exec { "${exports} disable missing access":
      command => $comment_no_access,
      onlyif  => "grep -E -v '^[^#].*access=.*' ${exports}",
      path    => [ '/usr/bin', '/bin'],
      notify  => Exec["exportfs"],
      require => File["/etc/exports"],
    }
  }

  if $manage_root_squash {
    # Ensure the root_squash option is set to -2 or -1 for each entry
    $fix_root_squash =
  "awk '{
    if (match(\$0, /[^#].*root_squash=(${allowed_root_squash_re}).*/)) {
    	print \$0
    } else {
      gsub(/,?root_squash=[^,]*/, \"\", \$2)
      printf \$1 \"\\t\" \"root_squash=${default_root_squash}\"
      if (match(\$2, /\\w/)) {
        printf \",\" \$2
      }
      printf \"\\n\"
    }
  }' ${exports} ${replace_exports}"
    exec { "${exports} enforce root squash":
      command => $fix_root_squash,
      onlyif  => "grep -E -v '^[^#].*root_squash=(${allowed_root_squash_re}).*' ${exports}",
      path    => [ '/usr/bin', '/bin'],
      notify  => Exec["exportfs"],
      require => File["/etc/exports"],
    }

  }

  if $manage_security {
    # Ensure the security option is set for each entry
    $fix_sec =
    "awk '{
      if (match(\$0, /[^#].*sec=(${allowed_security_methods_re}).*/)) {
      	print \$0
      } else {
        gsub(/,?sec=[^,]*/, \"\", \$2)
        printf \$1 \"\\t\" \"sec=${default_authentication}\"
        if (match(\$2, /\\w/)) {
          printf \",\" \$2
        }
        printf \"\\n\"
      }
    }' ${exports} ${replace_exports}"
  #   $fix_sec =
  # "awk '{ if (match(\$0, /[^#].*sec=${allowed_security_methods_re}.*/))
  # 	print \$0
  #   else
  #     gsub(/,?sec=[^,]*/, \"\", \$2)
  #     printf \$1 \"\\t\" \"sec=${default_authentication}\"
  #   if (match(\$2, /\\w/))
  #     printf \",\" \$2
  #   printf \"\\n\"
  # }' ${exports} ${replace_exports}"

    exec { "${exports} enforce security method":
      command => $fix_sec,
      onlyif  => "grep -E -v '^[^#].*sec=(${allowed_security_methods_re}).*' ${exports}",
      path    => ['/usr/bin', '/bin'],
      notify  => Exec["exportfs"],
      require => File["/etc/exports"],
    }

  }

  exec { "exportfs":
    command     => "exportfs -a",
    refreshonly => true,
    path        => ['/usr/sbin', '/sbin', '/usr/bin', '/bin'],
  }
}
