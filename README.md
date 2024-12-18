# FiTaDoServer (Firefox, Tailscale & Docker Compose Sync Server)

**FiTaDoServer** is a Docker Compose-based solution for self-hosting a Firefox Sync server using Tailscale. This project allows you to securely synchronize your Firefox data (bookmarks, history, tabs, passwords, etc.) across multiple devices over a private Tailscale network, eliminating the need for cloud-based services.

## ✨ Features

- **🔒 Self-Hosted Firefox Sync**: Keep your Firefox data within your private network.
- **🔐 Secure Tailscale Integration**: Leverage Tailscale for secure, private networking.
- **⚙️ Easy Setup**: Simplified deployment using Docker Compose.
- **🛠 Customizable Configuration**: Adjust settings to meet your specific needs, including database credentials and sync secrets.
- **📱 Multi-Device Sync**: Seamlessly synchronize data across all your Firefox installations.

## 🚀 Getting Started

### Prerequisites

- **Tailscale**: Visit [tailscale.com](https://tailscale.com/download) to install Tailscale.

    ```sh
    curl -fsSL https://tailscale.com/install.sh | sh
    ```

### Installation

1. **📥 Clone the Repository**:
    ```sh
    git clone https://github.com/JonCastaway/DockerComposeFFsync.git
    ```

2. **📂 Move to the Repository Directory and Docker Compose File**:
    ```sh
    cd DockerComposeFFsync && mv Docker-Compose.yaml ~/
    ```

3. **🔧 Build the Docker Container**:
    ```sh
    docker compose build
    ```

4. **📝 Modify `docker-compose.yml`**:
    - Change the database password.
    - Generate and set random `SYNC_MASTER_SECRET` and `METRICS_HASH_SECRET`.
    - Set `SYNC_URL`.

5. **🗄 Start the MariaDB Database**:
    ```sh
    docker compose up -d mariadb
    ```

6. **🔧 Initialize the Databases**: Run `initdb.sh` and provide your MariaDB root password.
    ```sh
    chmod +x initdb.sh
    ./initdb.sh
    ```

7. **📈 Bring Up the Rest of the Compose Stack**:
    ```sh
    docker compose up -d
    ```

8. **🦊 Configure Firefox**:
    - Go to `about:config` in Firefox.
    - Set `identity.sync.tokenserver.uri` to `http://YOURTAILSCALEHOSTNAME:8000/1.0/sync/1.5`.

9. **🚀 Try to Sync**!

## 🤝 Contributing

We welcome contributions! Please open an issue or submit a pull request with your improvements.

## 📜 License

This project is licensed under the **Mozilla Public License 2.0** - see the [LICENSE](LICENSE) file for details.

## 📝 Acknowledgements

Originally based on [mozilla-services/syncstorage-rs](https://github.com/mozilla-services/syncstorage-rs)
And [dan-r's syncstorage-rs-docker](https://github.com/dan-r/syncstorage-rs-docker). Special thanks to all contributors!.
