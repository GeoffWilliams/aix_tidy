# Aix_tidy::Ssh
#
# Manage SSH config files with puppet
#
# @param extra_config Extra configuration file settings
class aix_tidy::ssh(
    $extra_config = {}
) {

  file { "/etc/ssh/ssh_config":
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0644",
  }

  # Client protocol 2 only
  ssh_config { "Protocol":
    value  => "2",
  }

  class { "ssh":
    extra_config => $extra_config,
  }
}
