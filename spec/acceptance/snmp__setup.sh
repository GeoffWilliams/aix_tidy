groupadd system
cat > /etc/snmpd.conf <<END
logging         file=/usr/tmp/snmpd.log         enabled
logging         size=100000                     level=0

community       public
community       private 127.0.0.1 255.255.255.255 readWrite
#community       system  127.0.0.1 255.255.255.255 readWrite 1.17.2
community tripoli readWrite
community lucifer readWrite 6.6.6
view            1.17.2          system enterprises view

trap            public          127.0.0.1       1.2.3   fe      # loopback

#snmpd          maxpacket=1024 querytimeout=120 smuxtimeout=60

smux            1.3.6.1.4.1.2.3.1.2.1.2         gated_password  # gated
smux            1.3.6.1.4.1.2.3.1.2.2.1.1.2     dpid_password   #dpid

smux            1.3.6.1.4.1.2.3.1.2.1.3         xmtopas_pw      # xmtopas
END
