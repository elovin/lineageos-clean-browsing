# lineageos-clean-browsing

## About
This repo is a collection of scripts and config files to apply allowedlist/whitelist DNS filtering
to all traffic from or passing through a lineageos phone. 

In the future I might also add firewall scripts to apply ip block lists to block all known public proxy/vpn/tor ips.

## Attribution
The scripts in in this repo are inspired by these guides:

1. [Running shell scripts as root during boot on lineageos](https://ch1p.io/lineageos-run-shell-script-at-boot-as-root/)
2. [Running dnscrypt-proxy on android as a local DNS resolver](https://android.stackexchange.com/questions/207484/how-to-run-dnscrypt-as-a-background-service-on-android)


## Gettings started
You need to enable adb debugging and adb root debugging in the developer settings.


Tested with lineageos 20.1

1. Install ADB tools on your linux/mac (I have not tested it on windows)
2. Enable developer settings on your phone
3. Enable USB debugging and USB root debugging (On your lineageos phone)
6. Connect your phone (approve adb access)
7. Extend/Update the config files
8. Run the setup script 'bash ./setup.sh'
