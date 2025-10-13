#!/sbin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/50-lineage.sh
# During a LineageOS upgrade, this script backs up /system/etc/hosts,
# /system is formatted and reinstalled, then the file is restored.
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
etc/hosts
etc/myboot.sh
etc/init/myboot.rc
etc/dnscrypt-proxy.blocklist.txt
etc/dnscrypt-proxy.allowedlist.txt
etc/dnscrypt-proxy.cloaking-rules.txt
etc/dnscrypt-proxy.toml
bin/dnscrypt-proxy
etc/private_dns_name.txt
etc/force_private_dns.sh
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac
