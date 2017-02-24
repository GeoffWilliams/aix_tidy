# Aix_tidy::Ssh
#
# Manage SSH config files with puppet
#
# @param extra_config Extra configuration file settings
# @param banner_message Banner message to display to users or false to disable
# @param manage_x11_forwarding true to manage (..and disable) x11 forwarding
#   else leave unmanaged
# @param client_alive_interval ClientAliveInterval setting for sshd_config
# @param client_alive_count_max ClientAliveCountMax setting for sshd_config
class aix_tidy::ssh(
    $extra_config           = {},
    $banner_message         = false,
    $manage_x11_forwarding  = false,
    $client_alive_interval  = undef,
    $client_alive_count_max = undef,
) {

  $banner_file = "/etc/ssh/ssh_banner"

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

  # setup a banner if content passed in
  if $banner_message {
    file { $banner_file:
      ensure  => file,
      owner   => "root",
      group   => "root",
      mode    => "0644",
      content => $banner_message,
    }
    $manage_banner  = true
  } else {
    $manage_banner  = false
  }

  class { "ssh":
    extra_config           => $extra_config,
    banner                 => $banner_file,
    manage_banner          => $manage_banner,
    manage_x11_forwarding  => false,
    client_alive_interval  => client_alive_interval,
    client_alive_count_max => client_alive_count_max,
  }
}
