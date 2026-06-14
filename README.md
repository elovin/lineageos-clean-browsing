# lineageos-clean-browsing

- [lineageos-clean-browsing](#lineageos-clean-browsing)
  - [About](#about)
  - [Attribution](#attribution)
  - [Tested LineageOS versions](#tested-lineageos-versions)
  - [Tested Devices](#tested-devices)
  - [Setup](#setup)
  - [Known Issues](#known-issues)


## About
This repo is a collection of scripts to extend the features of google family link
so that thethering can no longer be used (because all family link filters do not apply to thethering clients and google will probably never fix this since its a feature which exists for android business).

* The thethering android settings page is blocked/disabled
(Because google family link does not cover thethering).

* It also disables/blocks the android settings page to configure DoH and VPNs

    and forces a specific private dns to be used 
    (this is only useful if you choose to allow all kind of websites in chrome, to be safe its better to use the family link allowlist instead)

* These adjustments are meant to be used together with google family link to prevent the user from installing apps which can break the DNS filter (e.g. cloudflare WARP, firefox with addons, it is best to stick to a mobile browser which does not allow the configuration of a DNS server or VPN addons (e.g. chrome))
  
  * I recommend using chrome with the google family link configuration to block all websites which are not on your allowed list 

## Attribution
The scripts in in this repo are inspired by these guides:

1. [Running shell scripts as root during boot on lineageos](https://ch1p.io/lineageos-run-shell-script-at-boot-as-root/)
2. [Running dnscrypt-proxy on android as a local DNS resolver](https://android.stackexchange.com/questions/207484/how-to-run-dnscrypt-as-a-background-service-on-android)

## Tested LineageOS versions


### Supported
* 23.2
* 22.2

### Deprecated
* 23.1  (Deprecated)
* 23.0  (Deprecated)
* 22.1  (Deprecated)
* 21    (Deprecated)
* 20    (Deprecated)

## Tested Devices

* Moto g7 power
* Moto g32 (Deprecated)
* OnePlus Ace 5

## Setup
You need to enable adb debugging and adb root debugging in the developer settings on your lineageOS device

1. Install ADB tools on your linux/mac (I have not tested it on windows)
2. Modify the `private_dns_name.txt` to point to the private dns you want to use (e.g. custom dnscrypt or custom cleanbrowsing dns)
3. Enable developer settings
4. Enable USB debugging and USB root debugging (On your lineageos phone)
5. Connect your phone (and then approve adb access on your phone)
6. Run the setup script 'bash ./setup.sh'
7. Check your phone for access confirmation

## Known Issues
1. The scripts currently run as root
    
    which may not be necessary when creating a proper SELINUX profile
    (see [the first attribution link](#attribution))

2. Flashing a new LineageOS mature version requires running the `setup.sh` script again.


## History

1. dnscrypt-support was removed since it only works for ipv4 and most mobile networks use ipv6
