@test "disabled private community" {
  grep "#community[[:space:]]*private" /etc/snmpd.conf
}

@test "disabled public community" {
  grep "#community[[:space:]]*public" /etc/snmpd.conf
}

@test "disabled system community" {
  grep "#community[[:space:]]*system" /etc/snmpd.conf
}

@test "disabled readWrite community settings" {
  ! grep "^community.*readWrite" /etc/snmpd.conf
}

@test "IP address restrictions in place" {
  grep "community tripoli 192.168.1.0 255.255.255.0 readOnly" /etc/snmpd.conf
}
