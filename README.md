# FiTaDoServer (Firefox, Tailscale & Docker Compose Sync Server)

**FiTaDoServer** is a Docker Compose-based solution for self-hosting a Firefox Sync server using Tailscale. This project allows you to securely synchronise your Firefox data (bookmarks, history, tabs, passwords, etc.) across multiple devices over a private Tailscale network, eliminating the need for cloud-based services.

## ✨ Features

- **🔒 Self-Hosted Firefox Sync**: Keep your Firefox data within your private network.
- **🔐 Secure Tailscale Integration**: Leverage Tailscale for secure, private networking.
- **⚙️ Easy Setup**: Simplified deployment using Docker Compose.
- **🛠 Customisable Configuration**: Adjust settings to meet your specific needs, including database credentials and sync secrets.
- **📱 Multi-Device Sync**: Seamlessly synchronise data across all your Firefox installations.

## 🚀 Getting Started

### Prerequisites

### Install and Set Up Tailscale

Tailscale is a modern VPN built on top of WireGuard that makes it easy to connect your devices securely across the internet.

Here are some key features:

- **Free for up to 100 users**: Ideal for individuals and small teams.
- **Flat mesh network**: Direct connections between devices without requiring a central server.
- **WireGuard protocol**: High-speed, low-latency
 
**If you don't have a Tailscale account sign up, it is free for up to 100 devices:**

you can sign up using this [Tailscale](https://tailscale.com).

1. **Install Tailscale**: Visit [tailscale.com](https://tailscale.com/download) to download and install Tailscale.

    ```sh
    curl -fsSL https://tailscale.com/install.sh | sh
    ```

2. **Run Tailscale**: After installing, start Tailscale with the following command:

    ```sh
    sudo tailscale up
    ```

3. **Log in to Tailscale**: Follow the instructions in the terminal to log in to Tailscale. This will usually open a browser window where you can authenticate your Tailscale account.

4. **Verify Tailscale Connection**: Ensure that your device is connected to the Tailscale network by checking the Tailscale status.

    ```sh
    tailscale status
    ```

### Installation

1. **📥 Clone the Repository**:
    ```sh
    git clone https://github.com/JonCastaway/FiTaDoServer.git
    ```

2. **📂 Move to the Repository Directory and Docker Compose File**:
    ```sh
    cd FiTaDoServer && mv Docker-Compose.yml ~/
    ```
    
3. **📂 Generate random password and add them to the Docker Compose File**:
    ```sh
    MYSQL_PASSWORD=$(cat /dev/urandom | base32 | head -c64)
    MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | base32 | head -c64)
    sed -i "s/YOUR_RANDOM_MYSQL_PASSWORD/$MYSQL_PASSWORD/g" docker-compose.yml
    sed -i "s/YOUR_RANDOM_MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" docker-compose.yml
    sed -i "s/YOUR_RANDOM_SYNC_MASTER_SECRET/$MYSQL_PASSWORD/g" docker-compose.yml
    sed -i "s/YOUR_RANDOM_METRICS_HASH_SECRET/$MYSQL_PASSWORD/g" docker-compose.yml
    ```

4. **🔧 Build the Docker Container**:
    ```sh
    docker compose build
    ```

5. **📝 Modify `docker-compose.yml`**:
    - Change the database password.
    - Generate and set random `SYNC_MASTER_SECRET` and `METRICS_HASH_SECRET`.
    - Set `SYNC_URL`.

6. **🗄 Start the MariaDB Database**:
    ```sh
    docker compose up -d mariadb
    ```

7. **🔧 Initialize the Databases**: Run `initdb.sh` and provide your MariaDB root password.
    ```sh
    chmod +x initdb.sh
    ./initdb.sh
    ```

8. **📈 Bring Up the Rest of the Compose Stack**:
    ```sh
    docker compose up -d
    ```

9. **🦊 Configure Firefox**:
    - Go to `about:config` in Firefox.
    - Set `identity.sync.tokenserver.uri` to `http://YOURTAILSCALEHOSTNAME:8000/1.0/sync/1.5`.

10. **🚀 Try to Sync**!

## 🤝 Contributing

We welcome contributions! Please open an issue or submit a pull request with your improvements.

## 📝 Acknowledgements

Originally based on [mozilla-services/syncstorage-rs](https://github.com/mozilla-services/syncstorage-rs) and with help from [dan-r's syncstorage-rs-docker](https://github.com/dan-r/syncstorage-rs-docker).

Special thanks to all contributors!
