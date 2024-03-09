# lineageos-clean-browsing

## About
This repo is a collection of scripts and config files to apply allowedlist/whitelist DNS filtering
to all traffic from or passing through a lineageos phone. 

* It blocks the android builtin DNS over TLS feature and redirects all regular DNS queries (using iptables)
to the custom port 55 where dnscrypt is configured to listen to.

* It also blocks the DoT port 853 in general since dnscrypt uses DNS over HTTPS.

* All traffic passing through the phone (Thethering wifi/bluetooth/usb) is blocked through iptables.
* Whitelists ip ranges for thethering based on the dnscrypt allowed domain list


## Attribution
The scripts in in this repo are inspired by these guides:

1. [Running shell scripts as root during boot on lineageos](https://ch1p.io/lineageos-run-shell-script-at-boot-as-root/)
2. [Running dnscrypt-proxy on android as a local DNS resolver](https://android.stackexchange.com/questions/207484/how-to-run-dnscrypt-as-a-background-service-on-android)

## Tested LineageOS versions

* (Deprecated) 20
* (WIP) 21

## Gettings started
You need to enable adb debugging and adb root debugging in the developer settings.

1. Install ADB tools on your linux/mac (I have not tested it on windows)
2. Modify the config files for dnscrypt and lineageos
3. 
4. Enable developer settings on your phone
5. Enable USB debugging and USB root debugging (On your lineageos phone)
6. Connect your phone (approve adb access)
7. Run the setup script 'bash ./setup.sh'

## Dependencies
1. [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy)
2. [busybox](https://github.com/Magisk-Modules-Repo/busybox-ndk)

## Known Issues
1. The scripts and services currently run as root, I might add a SELINUX profile in the future (see [the first attribution link](#attribution))
2. The Dnscrypt and busybox dependencies have to be updated manually
3. The ip whitelisting script (for thethering) based on the domains whitelisted for dnscrypt is WIP
4. The ip whitelisting script (for thethering) might not cover all necessary ips since there can be a lot of ips behind the same root domain
