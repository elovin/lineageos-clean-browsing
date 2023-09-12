# lineageos-clean-browsing

## About
This repo is a collection of scripts and config files to apply allowedlist/whitelist DNS (and some IP) filtering
to all traffic from or passing through a lineageos phone. 

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

## Dependencies
1. [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy)
2. [busybox](https://github.com/Magisk-Modules-Repo/busybox-ndk)

## Known Issues
1. The ip whitelisting script based on the domains whitelisted for dnscrypt is WIP
2. The ip whitelisting script might not cover all necessary ips since there can be a lot of ips behind the same root domain
   so for now you would need to add a lot of sub domains and/or a list of ip ranges to cover everything you need.
   (The whitelist is only necessary for tethering)
3. The scripts and services run with root which is probably not necessary (see [the first attribution link](#attribution))
4. No automatic update for the dependencies (could be done in the 50-lineage.sh script after the OTA update)
