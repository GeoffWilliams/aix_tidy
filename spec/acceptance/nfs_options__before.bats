@test "testcase nfs exports present" {
  grep 'localhost' /etc/exports
}
