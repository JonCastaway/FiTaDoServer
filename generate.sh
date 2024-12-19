#!/bin/bash
echo "Generating Tailscale device name..."
TAILSCALE_IP=$(tailscale status --json | jq -r '.Self.TailscaleIPs[0]')
echo "Tailscale device IP address: $TAILSCALE_IP"
echo "Generating random passwords..."
MYSQL_PASSWORD=$(cat /dev/urandom | base32 | head -c64)
MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | base32 | head -c64)
SYNC_MASTER_SECRET=$(cat /dev/urandom | base32 | head -c64)
METRICS_HASH_SECRET=$(cat /dev/urandom | base32 | head -c64)
echo "Generated MYSQL_PASSWORD: $MYSQL_PASSWORD"
echo "Generated MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
echo "Generated SYNC_MASTER_SECRET: $SYNC_MASTER_SECRET"
echo "Generated METRICS_HASH_SECRET: $METRICS_HASH_SECRET"
echo "Updating docker-compose.yml file..."
sed -i "s/YOUR_RANDOM_MYSQL_PASSWORD/$MYSQL_PASSWORD/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_SYNC_MASTER_SECRET/$SYNC_MASTER_SECRET/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_METRICS_HASH_SECRET/$METRICS_HASH_SECRET/g" docker-compose.yml
sed -i "s/TAILSCALE_IP/$TAILSCALE_IP/g" docker-compose.yml
echo "docker-compose.yml has been updated with the generated passwords and Tailscale device name."
