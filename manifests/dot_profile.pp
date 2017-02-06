# Aix_tidy::Dot_profile
#
# Install a default security profile
class aix_tidy::dot_profile {
  file { "/etc/security/.profile":
    ensure => file,
    owner  => "root",
    group  => "root",
    mode   => "0755",
    source => "puppet:///modules/aix_tidy/dot_profile",
  }
}
