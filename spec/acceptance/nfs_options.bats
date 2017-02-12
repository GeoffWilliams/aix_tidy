@test "localhost entries removed" {
  ! grep 'localhost' /etc/exports
}

@test "missing access entries disabled" {
  ! $(grep -v  '^.*access=.*' /etc/exports | grep -v '^#')
}

@test "missing root_squash fixed" {
  ! $(grep -v '^[^#].*root_squash=-2.*' /etc/exports | grep -v '^#')
}

@test "missing sec option fixed" {
  ! $(grep -v '^[^#].*sec=-2.*' /etc/exports | grep -v '^#')
}
