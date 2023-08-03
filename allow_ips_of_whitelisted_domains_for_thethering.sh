#!/usr/bin/env sh

# Whitelisted domains file path
WHITELIST_FILE="dnscrypt-proxy.allowedlist.txt"

# Iptables forwarding chain name
FORWARDING_CHAIN="FORWARD"

# Function to resolve IP address of a domain using BusyBox nslookup
resolve_ip() {
    domain="$1"
    ip_address=""

    # Use BusyBox nslookup and awk to extract IP address
    ip_address=$(busybox nslookup "$domain" 2>/dev/null | busybox awk '/^Address: / { print $2; exit }')

    echo "$ip_address"
}

# Check if the whitelist file exists
if [ ! -f "$WHITELIST_FILE" ]; then
    echo "Whitelist file not found: $WHITELIST_FILE"
    exit 1
fi

# Read each domain from the whitelist file using while-read loop, ignoring lines starting with '#' and empty lines
while IFS= read -r line; do
    # Ignore lines starting with '#' and empty lines
    case "$line" in
        \#*|'') continue ;;
    esac

    # Remove lines starting with '='
    line=$(echo "$line" | busybox awk '!/^=/{print}')

    # Resolve IP address using BusyBox nslookup
    ip=$(resolve_ip "$line")

    if [ -n "$ip" ]; then
        # Allow new IP address in iptables forwarding chain
        /system/bin/iptables -I "$FORWARDING_CHAIN" -d "$ip" -j ACCEPT
        echo "Allowed IP: $ip"
    else
        echo "Failed to resolve IP for domain: $line"
    fi
done < "$WHITELIST_FILE"
