#!/bin/sh

while :; do
	settings put global private_dns_mode hostname
	settings put global private_dns_specifier "$(cat /system/etc/private_dns_name.txt)"

	sleep 3;
done
