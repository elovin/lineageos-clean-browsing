#!/usr/bin/env sh

dnscrypt_version=$(cat dnscrypt-proxy.version.txt)

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

adb push dnscrypt-proxy.blocklist.txt /system/etc/
# e.g. apply google safe search and safe search for other sites you allowed
adb push dnscrypt-proxy.cloaking-rules.txt /system/etc/

# main config file
adb push dnscrypt-proxy.toml /system/etc/

# fetch dnscrypt-proxy binary
dnscrypt_proxy_file_name="dnscrypt-proxy-${dnscrypt_version}"

if [ ! -e "${dnscrypt_proxy_file_name}" ]; then
    curl -LO "https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/${dnscrypt_version}/dnscrypt-proxy-android_arm64-${dnscrypt_version}.zip"
    unzip -j "dnscrypt-proxy-android_arm64-${dnscrypt_version}.zip" '*/dnscrypt-proxy'
    mv dnscrypt-proxy "${dnscrypt_proxy_file_name}"
fi

# add dnscrypt-binary and make it executable
adb push "${dnscrypt_proxy_file_name}" /system/bin/dnscrypt-proxy
adb shell chmod +x /system/bin/dnscrypt-proxy

# /system/addon.d/50-lineage.sh
# to backup and restore files on upgrade
adb push 50-lineage.sh /system/addon.d/
adb shell chmod +x /system/addon.d/50-lineage.sh

# add hosts file to block subdomain of domains whitelisted in dnscrypt-proxy
adb push hosts /system/etc/hosts

# work around local dns not working for ipv6
adb push private_dns_name.txt /system/etc
adb push force_private_dns.sh /system/etc
adb shell chmod +x /system/etc/force_private_dns.sh
