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
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0640",
  }

  chmod_r { "/var/adm/ras":
    want_mode => "0640",
  }

  file { "/var/ct/RMstart.log":
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0640",
  }

  file { "/var/tmp/dpid2.log":
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0640",
  }

  file { "/var/tmp/hostmibd.log":
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0640",
  }

  file { "/var/tmp/snmpd.log":
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0640",
  }

  file { "/var/adm/sa":
    ensure => directory,
    owner  => "adm",
    group  => "adm",
    mode   => "0755",
  }

  file { "/var/adm/cron":
    ensure => directory,
    owner  => "bin",
    group  => "cron",
    mode   => "0550",
  }

  file { "/etc/inetd.conf":
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0644",
  }

  file { "/tmp":
    ensure => directory,
    owner  => "bin",
    group  => "bin",
    mode   => "1777",
  }
}
