#!/bin/sh

# disable access to tethering settings
pm set-user-restriction --user 0 no_config_tethering 1

# block dns over TLS from phone or tethering
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
