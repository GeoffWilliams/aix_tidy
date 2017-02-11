# Aix_tidy::Sendmail
#
# Minor enhancements to sendmail:
# * Remove MTA information from server hello
# * Manage permissions on critical files
class aix_tidy::sendmail {

  # Remove MTA information from greeting
  file_line { "/etc/mail/sendmail.cf SmtpGreetingMessage":
    ensure => present,
    path   => "/etc/mail/sendmail.cf",
    match  => "^O SmtpGreetingMessage=.*",
    line   => "O SmtpGreetingMessage=mailerready",
  }

  file { "/etc/mail/sendmail.cf":
    ensure => file,
    owner  => "root",
    group  => "system",
    mode   => "0640",
  }

  file { "/var/spool/mqueue":
    ensure => directory,
    owner  => "root",
    group  => "system",
    mode   => "0700",
  }
}
