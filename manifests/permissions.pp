# Aix_tidy::Permissions
#
# Lockdown common file permissions on AIX
class aix_tidy::permissions {

  chown_r { "/etc/security":
    want_user  => "root",
    want_group => "security",
    skip       => "/etc/security/audit",
  }

  chmod_r { "/etc/security":
    want_mode => "0644",
    skip      => "/etc/security/audit",
  }

  file { "/etc/group":
    ensure => file,
    owner  => "root",
    group  => "security",
    mode   => "0644",
  }

  file { "/etc/passwd":
    ensure => file,
    owner  => "root",
    group  => "security",
    mode   => "0644",
  }

  chown_r { "/etc/security/audit":
    want_user  => "root",
    want_group => "audit",
  }

  chmod_r { "/etc/security/audit":
    want_mode => "0644",
  }

  file { "/audit":
    ensure => directory,
    owner  => "root",
    group  => "audit",
  }

  chmod_r { "/audit":
    want_mode => "0640"
  }


  file { "/smit.log":
    mode => "0640",
  }

  chmod_r { "/var/adm/ras":
    want_mode => "0640",
  }

  file { "/var/ct/RMstart.log":
    mode => "0640",
  }

  file { "/var/tmp/dpid2.log":
    mode => "0640",
  }

  file { "/var/tmp/hostmibd.log":
    mode => "0640",
  }

  file { "/var/tmp/snmpd.log":
    mode => "0640",
  }

  file { "/var/adm/sa":
    ensure => directory,
    owner  => "adm",
    group  => "adm",
    mode   => "0755",
  }

#
# Search and remediate any user configuration files which have group or world writable
# access: lsuser -a home ALL |cut -f2 -d= | while read HOMEDIR; do
# echo "Examining $HOMEDIR"
# if [ -d $HOMEDIR ]; then
# ls -a $HOMEDIR | grep -Ev
# "^.$|^..$" | \
# while read FILE; do
# if [ -f $FILE ]; then
# ls -l $FILE
# chmod go-w $FILE
# fi
# done
# else
# echo "No home dir for $HOMEDIR"
# fi
# done
# AIX6.x/7.x_180
# Permissions and Ownership - home directory permissions
# All user home directories must not have group write or world writable access.
# Change any home directories which have group or world writable access:
# NEW_PERMS=750
# lsuser -c ALL | grep -v ^#name | cut -f1 -d: | while read NAME; do if
# [ `lsuser -f $NAME | grep id | cut -f2 -d=` -ge 200 ]; then HOME=`lsuser -a home $NAME | cut -f 2 -d =`
# echo "Changing $NAME homedir
# $HOME"
# chmod $NEW_PERMS $HOME
# fi
# done
# NOTE: The permission change is automatically applied to all user directories with a user ID over 200.
# Modify /usr/lib/security/mkuser.sys to ensure that all new user home directories will be created with a default permission of 750:
# vi /usr/lib/security/mkuser.sys
# Replace:
# mkdir $1
# With:
# mkdir $1 && chmod u=rwx,g=rx,g=
# $1
# AIX6.x/7.x_181
# File Permissions - /tmp
# If "sticky bit" is set on a directory, then only the owner of a file can remove that file from the directory.
# Set sticky bit File: /tmp
# Prudential Corporation Asia, COMMERCIAL IN CONFIDENCE 39
# Regional IT Security, IBM AIX Server Security Configuration Standard
#
# AIX6.x/7.x_182
# Permissions and Ownership - world/group writable directory in root PATH
# To secure the root users executable PATH, all directories must not be group and world writable.
# To manually change permissions on the directories:
# To remove group writable access: chmod g-w <dir name>
# To remove world writable access:
# chmod o-w <dir name>
# To remove both group and world writable access:
# chmod go-w <dir name>
# To change the owner of a directory:
# chown <owner> <dir name>
}
