#!/bin/bash
echo "Generating Tailscale IP Address..."
TAILSCALE_IP=$(tailscale status --json | jq -r '.Self.TailscaleIPs[0]')
echo "/Your Tailscale device IP address is: $TAILSCALE_IP"
echo "Generating random MYSQL passwords..."
MYSQL_PASSWORD=$(cat /dev/urandom | base32 | head -c64)
MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | base32 | head -c64)
SYNC_MASTER_SECRET=$(cat /dev/urandom | base32 | head -c64)
METRICS_HASH_SECRET=$(cat /dev/urandom | base32 | head -c64)
echo "Adding the random password to docker-compose.yml..."
sed -i "s/YOUR_RANDOM_MYSQL_PASSWORD/$MYSQL_PASSWORD/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_SYNC_MASTER_SECRET/$SYNC_MASTER_SECRET/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_METRICS_HASH_SECRET/$METRICS_HASH_SECRET/g" docker-compose.yml
sed -i "s/YOUR_TAILSCALE_IP/$TAILSCALE_IP/g" docker-compose.yml
echo "docker-compose.yml has been updated with the generated passwords and this devices Tailscale IP address."
