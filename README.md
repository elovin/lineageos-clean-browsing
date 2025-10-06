# lineageos-clean-browsing

- [lineageos-clean-browsing](#lineageos-clean-browsing)
  - [About](#about)
  - [Attribution](#attribution)
  - [Tested LineageOS versions](#tested-lineageos-versions)
  - [Tested Devices](#tested-devices)
  - [Setup](#setup)
  - [Dependencies](#dependencies)
  - [Known Issues](#known-issues)


## About
This repo is a collection of scripts and config files 
to enforce allowedlist (AKA whitelist) DNS filtering on a lineageos phone.

* It disables/blocks the android settings page to configure DoH and VPNs

    and redirects all regular DNS queries including queries from LineageOS
    to the custom port 55 on which dnscrypt-proxy is configured to listen.

* It also disables/blocks the DoT port 853 in general since dnscrypt-proxy does not need it.

* The tethering android settings page is also blocked/disabled
(Because google family link does not cover thethering).

* These adjustments are meant to be used together with google family link to prevent the user from installing apps which can break the DNS filter (e.g. cloudflare WARP, firefox with addons, it is best to stick to a mobile browser which does not allow the configuration of a DNS server or VPN addons (e.g. chrome))
  
  * I recommend using chrome with the google family link configuration to block all websites which are not on your allowed list 

## Attribution
The scripts in in this repo are inspired by these guides:

1. [Running shell scripts as root during boot on lineageos](https://ch1p.io/lineageos-run-shell-script-at-boot-as-root/)
2. [Running dnscrypt-proxy on android as a local DNS resolver](https://android.stackexchange.com/questions/207484/how-to-run-dnscrypt-as-a-background-service-on-android)

## Tested LineageOS versions

* 22.2
* 22.1
* 21 (Deprecated)
* 20 (Deprecated)

## Tested Devices

* Moto g7 power
* Moto g32

## Setup
You need to enable adb debugging and adb root debugging in the developer settings on your lineageOS device

1. Install ADB tools on your linux/mac (I have not tested it on windows)
2. Modify the config files for DNSCrypt (otherwise it will just use the controld public resolver)

    2.1 To generate your own DNSCrypt stamp for your prefered DNS resolver you can use the stamp generator from [DNSCrypt](https://dnscrypt.info/stamps/)
3. Enable developer settings
4. Enable USB debugging and USB root debugging (On your lineageos phone)
5. Connect your phone (and then approve adb access on your phone)
6. Run the setup script 'bash ./setup.sh'

## Dependencies
1. [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy)

## Known Issues
1. The startup script and dnscrypt-proxy currently run as root
    
    which may not be necessary when creating a proper SELINUX profile
    (see [the first attribution link](#attribution))
2. Blocking the Thethering, DNS and VPN settings pages
 crashes the settings app if you try to access these pages
   
    * So you might need to configure them before using the startup script
1. No auto updates for the dnscrypt binary
   
   Although it is probably enough to update dnscrypt-proxy when flashing a new LineageOS mature version

2. Flashing a new LineageOS mature version requires running the `setup.sh` script again.
