# Aix_tidy::Disable_chrctcp
#
# Disable specified services using the chrctcp module, see https://forge.puppet.com/geoffwilliams/chrctcp/readme
#
# @param disable Array of services to disable
class aix_tidy::disable_chrctcp(
    Array[String] $disable = []
) {

  chrctcp { $disable:
    ensure => 'disabled',
  }
}
