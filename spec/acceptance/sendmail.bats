# BATS test file to run after executing 'examples/init.pp' with puppet.
#
# For more info on BATS see https://github.com/sstephenson/bats

# Tests are really easy! just the exit status of running a command...
@test "old greeting line gone" {
  ! grep 'O SmtpGreetingMessage=$j Sendmail $b' /etc/mail/sendmail.cf
}

@test "correct greeting line present" {
  grep 'O SmtpGreetingMessage=mailerready' /etc/mail/sendmail.cf
}
