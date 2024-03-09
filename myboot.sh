#!/bin/sh

# disable private dns, so that the dnscrypt-proxy can not be bypassed from the android UI
settings put global private_dns_mode off

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


##### Tethering handling

### block all tcp/udp traffic from tethering by default 
/system/bin/iptables -I FORWARD -p udp --dport 1:65535 -j DROP
/system/bin/iptables -I FORWARD -p tcp --dport 1:65535 -j DROP
