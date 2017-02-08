# Aix_tidy::User_attributes
#
# Set AIX attributes to prevent remote logins on system accounts
class aix_tidy::user_attribute_lockdown {
  $user_lockdown = [
    "daemon",
    "bin",
    "sys",
    "adm",
    "nobody",
    "uucp",
    "lpd",
  ]
  user { $user_lockdown:
    ensure     => present,
    attributes => ['login=false','rlogin=false'],
  }
}
