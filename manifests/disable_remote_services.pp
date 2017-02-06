# Aix_tidy::Disable_remote_services
#
# Disable r* commands and daemons
class aix_tidy::disable_remote_services {

  $commands = ["/usr/bin/rcp", "/usr/bin/rlogin", "/usr/bin/rsh"]
  $daemons  = ["/usr/sbin/rlogind", "/usr/sbin/rshd", "/usr/sbin/tftpd"]

  file { $commands:
    mode => "0000",
  }

  file { $daemons:
    mode => "0000",
  }
}
