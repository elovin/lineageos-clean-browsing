#!/bin/sh

sleep 5;

# this setting only works after boot has been completed
pm set-user-restriction --user 0 no_config_vpn 1

while :; do
	# reset private dns every 5 seconds
	settings put global private_dns_mode hostname
	settings put global private_dns_specifier "$(cat /system/etc/private_dns_name.txt)"

	sleep 5;
done
