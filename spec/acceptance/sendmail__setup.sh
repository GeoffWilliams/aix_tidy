#!/bin/bash
mkdir /etc/mail
groupadd system

cat > /etc/mail/sendmail.cf << 'END'
# delimiter (operator) characters (old $o macro)
O OperatorChars=.:%@!^/[]+

# shall I avoid calling initgroups(3) because of high NIS costs?
#O DontInitGroups=False
...skipping...

# SMTP initial login message (old $e macro)
O SmtpGreetingMessage=$j Sendmail $b

# UNIX initial From header format (old $l macro)
O UnixFromLine=From $g $d

# From: lines that have embedded newlines are unwrapped onto one line
#O SingleLineFromHeader=False
END
