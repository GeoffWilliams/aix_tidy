@test "localhost entries removed" {
  ! grep 'localhost' /etc/exports
}
