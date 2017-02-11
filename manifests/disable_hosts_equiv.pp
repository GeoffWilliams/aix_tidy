# Aix_tidy::Disable_hosts_equiv
#
# Disable all hosts.equiv entries by commenting them out
class aix_tidy::disable_hosts_equiv {

  # no sed -i on AIX so must move manually..sigh
  $fix_cmd = 'sed \'s/\(^[^#].*$\)/# \1/\' /etc/hosts.equiv  > /etc/hosts.equiv.work && mv hosts.equiv.work hosts.equiv '
  $test_cmd = 'grep ^[^#] /etc/hosts.equiv'

  exec { "fix_hosts_equiv":
    command => $fix_cmd,
    onlyif  => $test_cmd,
    path    => ['/usr/bin','/bin'],
  }

  file { "/etc/hosts.equiv":
    ensure  => file,
    owner   => "root",
    group   => "system",
    mode    => "0644",
    require => Exec[fix_hosts_equiv],
  }
}
