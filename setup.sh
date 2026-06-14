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


# /system/etc/restrict_settings.sh
adb push restrict_settings.sh /system/etc/
adb shell chmod +x /system/etc/restrict_settings.sh


adb push private_dns_name.txt /system/etc
# /system/etc/force_private_dns.sh
adb push force_private_dns.sh /system/etc/
adb shell chmod +x /system/etc/force_private_dns.sh


# /system/addon.d/50-lineage.sh
# to backup and restore files on upgrade
adb push 50-lineage.sh /system/addon.d/
adb shell chmod +x /system/addon.d/50-lineage.sh
