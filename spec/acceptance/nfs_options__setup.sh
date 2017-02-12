groupadd system
touch /usr/sbin/exportfs
chmod +x /usr/sbin/exportfs
cat > /etc/exports << END
/usr/games    -ro,access=ballet:jazz:tap
/home         -root=ballet,access=ballet
/var/tmp
/usr/lib      -access=clients,sec=none,root_squash=666
/accounts/database -vers=4,sec=krb5,access=localhost:oracle99,accmachines,root=accmachine1
/tmp          -vers=3,ro
/tmp          -vers=4,sec=krb5,access=oracle99:localhost:central,accmachines,root=accmachine1
END
