#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to log messages
log_message() {
    echo "$(date '+%d-%m-%Y %H:%M:%S') - $1"
}

# 1. Install and Set Up Tailscale
log_message "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

log_message "Starting Tailscale..."
sudo tailscale up

log_message "Verifying Tailscale connection..."
tailscale status

# 2. Clone the Repository
log_message "Cloning the repository..."
git clone https://github.com/JonCastaway/FiTaDoServer.git
cd FiTaDoServer

# 3. Generate Random Passwords and Get Tailscale IP
log_message "Generating random passwords and Tailscale IP..."
TAILSCALE_IP=$(tailscale status --json | jq -r '.Self.TailscaleIPs[0]')
MYSQL_PASSWORD=$(cat /dev/urandom | base32 | head -c64)
MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | base32 | head -c64)
SYNC_MASTER_SECRET=$(cat /dev/urandom | base32 | head -c64)
METRICS_HASH_SECRET=$(cat /dev/urandom | base32 | head -c64)

log_message "Updating docker-compose.yml with generated values..."
sed -i "s/YOUR_RANDOM_MYSQL_PASSWORD/$MYSQL_PASSWORD/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_SYNC_MASTER_SECRET/$SYNC_MASTER_SECRET/g" docker-compose.yml
sed -i "s/YOUR_RANDOM_METRICS_HASH_SECRET/$METRICS_HASH_SECRET/g" docker-compose.yml
sed -i "s/YOUR_TAILSCALE_IP/$TAILSCALE_IP/g" docker-compose.yml

# 4. Build the Docker Container
log_message "Building the Docker container..."
docker compose build

# 5. Start the MariaDB Database
log_message "Starting the MariaDB database..."
docker compose up -d mariadb

# 6. Initialise the Databases
log_message "Initializing the databases..."
docker exec -it firefox_mariadb mysql -uroot -p -e "
CREATE DATABASE IF NOT EXISTS syncstorage_rs;
CREATE DATABASE IF NOT EXISTS tokenserver_rs;
GRANT ALL PRIVILEGES ON syncstorage_rs.* TO 'sync'@'%';
GRANT ALL PRIVILEGES ON tokenserver_rs.* TO 'sync'@'%';"

# 7. Bring Up the Rest of the Compose Stack
log_message "Bringing up the rest of the Docker Compose stack..."
docker compose up -d

log_message "Setup complete!"
