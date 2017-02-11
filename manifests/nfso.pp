# Aix_tidy::Nfso
#
# Manage /etc/tunables/nextboot on AIX using the nfso command and puppet.
#
# @param settings Hash of settings to enforce as key-value pairs, eg:
#   $settings = {"portcheck"=>"1"}
class aix_tidy::nfso(
  Hash[String, String] $settings = {}
) {

  $settings.each |$key, $value| {
    aix_nfso { $key:
      value => $value
    }
  }
}
