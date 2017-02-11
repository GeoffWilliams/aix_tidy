# Aix_tidy::Trustchk
#
# Manage Trusted Execution (TE) with Puppet on AIX using the trustchk command
#
# @param settings Hash of settings to enforce as key-value pairs, eg:
#   $settings = {"TE"=>"ON"}
class aix_tidy::trustchk(
  Hash[String, String] $settings = {}
) {

  $settings.each |$key, $value| {
    aix_trustchk { $key:
      value => $value
    }
  }
}
