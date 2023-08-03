#!/usr/bin/env sh

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
dnscryptVersion="2.1.4"
curl -LO "https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/${dnscryptVersion}/dnscrypt-proxy-android_arm64-${dnscryptVersion}.zip"
unzip -j "dnscrypt-proxy-android_arm64-${dnscryptVersion}.zip" '*/dnscrypt-proxy'

# add dnscrypt-binary and make it executable
adb push dnscrypt-proxy /system/bin/
adb shell chmod +x /system/bin/dnscrypt-proxy

# fetch busybox android arm64 build for the firewall scripts
curl -LO "https://github.com/Magisk-Modules-Repo/busybox-ndk/raw/master/busybox-arm64-selinux"

# add busybox-binary and make it executable
adb push busybox-arm64-selinux /system/bin/busybox
adb shell chmod +x /system/bin/busybox

# /system/addon.d/50-lineage.sh
# to backup and restore files on upgrade
adb push 50-lineage.sh /system/addon.d/
adb shell chmod +x /system/addon.d/50-lineage.sh

adb push hosts /system/etc/hosts
