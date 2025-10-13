#!/bin/sh

sleep 5;

pm set-user-restriction --user 0 no_config_vpn 1

while :; do
	# disable access to vpn settings
	settings put global private_dns_mode hostname
	settings put global private_dns_specifier "$(cat /system/etc/private_dns_name.txt)"

	sleep 5;
done
