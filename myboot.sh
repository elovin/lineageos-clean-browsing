#!/bin/sh

# disable private dns, so that the dnscrypt-proxy is used
settings put global private_dns_mode off

# block dns over lts from phone or tethering
/system/bin/iptables -I OUTPUT -p udp --dport 853 -j DROP
/system/bin/iptables -I OUTPUT -p tcp --dport 853 -j DROP

/system/bin/iptables -I FORWARD -p udp --dport 853 -j DROP
/system/bin/iptables -I FORWARD -p tcp --dport 853 -j DROP

# forward tethering traffic to internal dns
/system/bin/iptables -t nat -I PREROUTING -p udp --dport 53 -j DNAT --to 127.0.0.1:55
/system/bin/iptables -t nat -I PREROUTING -p tcp --dport 53 -j DNAT --to 127.0.0.1:55
echo -n 1 >/proc/sys/net/ipv4/conf/all/route_localnet

# redirect regular dns queries from phone to dnscrypt
/system/bin/iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to 127.0.0.1:55
/system/bin/iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to 127.0.0.1:55


##### Tethering handling

### block all tcp/udp traffic from tethering (until we have a propper ip blocklist + port block list in place to block SOCKS5 / VPNs / Tor)
/system/bin/iptables -I FORWARD -p udp --dport 1:65535 -j DROP
/system/bin/iptables -I FORWARD -p tcp --dport 1:65535 -j DROP

# WIP

### block tethering outside workhours
# Drop forwarding on weekdays (Monday to Friday) between 22 pm and 8 am
#/system/bin/iptables -I FORWARD -m time --timestart 22:00 --timestop 08:00 --weekdays Mon,Tue,Wed,Thu,Fri -j DROP

# Drop forwarding on weekends (Saturday and Sunday)
#/system/bin/iptables -I FORWARD -m time --timestart 00:00 --timestop 23:59 --weekdays Sat,Sun -j DROP


