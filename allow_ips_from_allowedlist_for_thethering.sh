#!/bin/sh

# Whitelisted domains file path
WHITELIST_FILE="dnscrypt-proxy.allowedlist.txt"

# Iptables forwarding chain name
FORWARDING_CHAIN="FORWARD"

# Function to resolve IP address of a domain using BusyBox nslookup
resolve_ip() {
    domain="$1"
    ip_address=""

    # Use BusyBox nslookup and awk to extract IP address
    ip_address=$(/system/bin/busybox nslookup "$domain" 2>/dev/null | /system/bin/busybox awk '/^Address: / { print $2; exit }')

    echo "$ip_address"
}

# Read each domain from the whitelist file using while-read loop, ignoring lines starting with '#' and empty lines
lookup_and_prepend_ips_based_on_dns_allowedlist_to_forwardchain(){
    while IFS= read -r line; do
        # Remove leading and trailing whitespace using BusyBox awk
        line=$(echo "$line" | /system/bin/busybox awk '{$1=$1};1')

        # Remove the character '=' from the line using gsub in awk
        line=$(echo "$line" | /system/bin/busybox awk '{gsub(/=/, ""); print}')

        # Ignore lines starting with '#' and empty lines
        case "$line" in
            \#*|'') continue ;;
        esac
    
        # Resolve IP address using BusyBox nslookup
        ip=$(resolve_ip "$line")
    
        if [ -n "$ip" ]; then
            # Prepend new IP address range to iptables forwarding chain
            /system/bin/iptables -I "$FORWARDING_CHAIN" -d "$ip/24" -j ACCEPT
            echo "Allowed Subnet: '$ip/24'"
        else
            echo "Failed to resolve IP for domain: $line"
        fi
    done < "$WHITELIST_FILE"
}

main(){
    # Check if the whitelist file exists
    if [ ! -f "$WHITELIST_FILE" ]; then
        echo "Whitelist file not found: $WHITELIST_FILE"
        exit 1
    fi

    while true; do
        # looup and prepend ip ranges, continue on error, run in background subshell
        (lookup_and_prepend_ips_based_on_dns_allowedlist_to_forwardchain || true) &
        # Sleep for 10 minutes (600 seconds)
        /system/bin/sleep 600
    done
}

main
