# Aix_tidy::Chsec
#
# Process chsec commands en-mass to set password policy on AIX
#
# @param values hash of chsec settings to enforce (see https://docs.puppet.com/puppet/latest/function.html#createresources)
class aix_tidy::chsec($values = {}) {
  $defaults = {
    ensure => present,
    stanza => 'default'
  }

  create_resources("chsec", $values, $defaults)
}
