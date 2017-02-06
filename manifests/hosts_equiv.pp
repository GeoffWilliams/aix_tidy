# Aix_tidy::Hosts_equiv
#
# Disable hosts_equiv by installing an empty file
class aix_tidy::hosts_equiv {
  file { "/etc/hosts.equiv":
    ensure  => file,
    owner   => "root",
    group   => "system",
    mode    => "0644",
    content => "# disabled by puppet"
  }
}
