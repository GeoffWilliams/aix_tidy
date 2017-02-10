# Aix_tidy::No
#
# Manage /etc/tunables/nextboot on AIX using the no command and puppet.
#
# @param settings Hash of settings to enforce as key-value pairs, eg:
#   $settings = {"tcp_recvspace"=>"262144", "tcp_mssdflt"=>"1448"}
class aix_tidy::no(
  Hash[String, String] $settings = {}
) {

  $settings.each |$key, $value| {
    aix_no { $key:
      value => $value
    }
  }
}
