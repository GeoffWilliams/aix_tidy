# Aix_tidy::Disable_inetd_service
#
# Use chsubserver to disable a list of inetd services
#
# @param disable Array of services to disable, see
#   https://forge.puppet.com/geoffwilliams/chsubserver/readme for information on
#   titleformats the puppet chsubserver type accepts
class aix_tidy::disable_inetd_service(
    Array[String] $disable = []
) {

  chsubserver { $disable:
    ensure => disabled
  }
}
