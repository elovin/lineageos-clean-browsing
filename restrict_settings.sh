#!/bin/sh

sleep 5;

# disable access to vpn settings
pm set-user-restriction --user 0 no_config_vpn 1
# disable access to tethering settings
pm set-user-restriction --user 0 no_config_tethering 1
