# lineageos-clean-browsing

## About
This repo is a collection of scripts and config files to apply allowedlist/whitelist DNS filtering
to all traffic from or passing through a lineageos phone. 

* It blocks the android builtin DNS over TLS feature and redirects all regular DNS queries (using iptables)
to the custom port 55 on which dnscrypt is configured to listen.

* It also blocks the DoT port 853 in general since dnscrypt does not need it.

* All traffic passing through the phone (Thethering wifi/bluetooth/usb) is blocked through iptables (Because google family link does not cover thethering).

* These adjustments are meant to be used together with google family link to prevent the user from installing apps which can break the DNS filter (e.g. cloudflare WARP)

## Attribution
The scripts in in this repo are inspired by these guides:

1. [Running shell scripts as root during boot on lineageos](https://ch1p.io/lineageos-run-shell-script-at-boot-as-root/)
2. [Running dnscrypt-proxy on android as a local DNS resolver](https://android.stackexchange.com/questions/207484/how-to-run-dnscrypt-as-a-background-service-on-android)

## Tested LineageOS versions

* 21
* (Deprecated) 20

## Gettings started
You need to enable adb debugging and adb root debugging in the developer settings.

1. Install ADB tools on your linux/mac (I have not tested it on windows)
2. Modify the config files for dnscrypt and lineageos
4. Enable developer settings on your phone
5. Enable USB debugging and USB root debugging (On your lineageos phone)
6. Connect your phone (approve adb access)
7. Run the setup script 'bash ./setup.sh'

## Dependencies
1. [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy)

## Known Issues
1. The scripts and services currently run as root, which is not necessary (see [the first attribution link](#attribution))
3. No auto updates for the dnscrypt binary
