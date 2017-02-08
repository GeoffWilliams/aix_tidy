# Aix_tidy::Disable_chrctcp
#
# Disable specified services using chrctcp
#
# @param disable Array of services to disable
class aix_tidy::disable_chrctcp(
    Array[String] $disable = []
) {

  chrctcp { $disable:
    ensure => 'disabled',
  }
}
