#!/usr/bin/env sh

dnscrypt_version="2.1.5"

while ! adb root; do
    echo "Waiting for adb root authorization..."
    echo "This will only work if you have lineageos root debuggin enabled"
    echo "You will also have to confirm the prompt on your phone"
    sleep 5
done

adb remount /

# /system/etc/init/myboot.rc
adb push myboot.rc /system/etc/init/

# /system/etc/myboot.sh
adb push myboot.sh /system/etc/
adb shell chmod +x /system/etc/myboot.sh

# /system/etc/allow_ips_from_allowedlist_for_thethering.sh
adb push allow_ips_from_allowedlist_for_thethering.sh /system/etc/
adb shell chmod +x /system/etc/allow_ips_from_allowedlist_for_thethering.sh

# add dnscrypt-proxy files
# add sites you want to allow / whitelist
adb push dnscrypt-proxy.allowedlist.txt /system/etc/
# default is to block everything so that only what we allow works
adb push dnscrypt-proxy.blocklist.txt /system/etc/
# e.g. apply google safe search and safe search for other sites you allowed
adb push dnscrypt-proxy.cloaking-rules.txt /system/etc/

# main config file
adb push dnscrypt-proxy.toml /system/etc/

# fetch dnscrypt-proxy binary
curl -LO "https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/${dnscrypt_version}/dnscrypt-proxy-android_arm64-${dnscrypt_version}.zip"
unzip -j "dnscrypt-proxy-android_arm64-${dnscrypt_version}.zip" '*/dnscrypt-proxy'

# add dnscrypt-binary and make it executable
adb push dnscrypt-proxy /system/bin/
adb shell chmod +x /system/bin/dnscrypt-proxy

# /system/addon.d/50-lineage.sh
# to backup and restore files on upgrade
adb push 50-lineage.sh /system/addon.d/
adb shell chmod +x /system/addon.d/50-lineage.sh

# add hosts file to block subdomain of domains whitelisted in dnscrypt-proxy
adb push hosts /system/etc/hosts
