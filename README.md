# Docker Compose Firefox Sync using Tailscale

A Docker Compose container to get started with [mozilla-services/syncstorage-rs](https://github.com/mozilla-services/syncstorage-rs) to self-host a Firefox sync server over Tailscale.

## Getting Started

1. **Install Tailscale**: [tailscale.com](https://tailscale.com/download).

   ```sh
   curl -fsSL https://tailscale.com/install.sh | sh
   ```

3. **Clone the Repository**:
    ```sh
    git clone https://github.com/JonCastaway/DockerComposeFFsync.git
    ```

4. **Move to the Repository Directory and Docker Compose File**:
    ```sh
    cd DockerComposeFFsync && mv Docker-Compose.yaml ~/
    ```

5. **Build the Docker Container**:
    ```sh
    docker compose build
    ```

6. **Modify `docker-compose.yml`**:
    - Change the database password.
    - Generate and set random `SYNC_MASTER_SECRET` and `METRICS_HASH_SECRET`.
    - Set `SYNC_URL`.

7. **Start the MariaDB Database**:
    ```sh
    docker compose up -d mariadb
    ```

8. **Initialize the Databases**: Run `initdb.sh` and provide your MariaDB root password.
    ```sh
    chmod +x initdb.sh
    ./initdb.sh
    ```

9. **Bring Up the Rest of the Compose Stack**:
    ```sh
    docker compose up -d
    ```

10. **Configure Firefox**:
    - Go to `about:config` in Firefox.
    - Set `identity.sync.tokenserver.uri` to `http://YOURTAILSCALEHOSTNAME:8000/1.0/sync/1.5`.

11. **Try to Sync**!
