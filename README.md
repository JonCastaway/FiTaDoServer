# 🦊🚀 FiTaDoServer

## (Firefox, Tailscale & Docker Compose Sync Server)

**FiTaDoServer** is a Docker Compose-based solution for self-hosting a Firefox Sync server using Tailscale. This project allows you to securely synchronise your Firefox data (bookmarks, history, tabs, passwords, etc.) across multiple devices over a private Tailscale network, eliminating the need for cloud-based services.

## ✨ Features

- **🔒 Self-Hosted Firefox Sync**: Keep your Firefox data within your private network.
- **🔐 Secure Tailscale Integration**: Leverage Tailscale for secure, private networking.
- **⚙️ Easy Setup**: Simplified deployment using Docker Compose.
- **🛠 Customisable Configuration**: Adjust settings to meet your specific needs, including database credentials and sync secrets.
- **📱 Multi-Device Sync**: Seamlessly synchronise data across all your Firefox installations.

## 🚀 Getting Started

### Prerequisites

#### Install and Set Up Tailscale

Tailscale is a modern VPN built on top of WireGuard that makes it easy to connect your devices securely across the internet.

Here are some key features:

- **Free for up to 100 users**: Ideal for individuals and small teams.
- **Flat mesh network**: Direct connections between devices without requiring a central server.
- **WireGuard protocol**: High-speed, low-latency encryption.

**If you don't have a Tailscale account yet, sign up for free (up to 100 devices)**: [Sign Up for Tailscale](https://tailscale.com).

1. **Install Tailscale**: Visit [tailscale.com](https://tailscale.com/download) to download and install Tailscale or use the bash command below:

    ```sh
    curl -fsSL https://tailscale.com/install.sh | sh
    ```

2. **Run Tailscale**: After installing, you may require a reboot if you receive an error. Start Tailscale with the following command:

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

2. **🔐 Generate Random Passwords and Get Your Tailscale IP address, add these to the Docker Compose File**:

    ```sh
    chmod +x stage1.sh
    ./stage1.sh
    ```

3. **🔧 Build the Docker Container**:

    ```sh
    docker compose build
    ```

4. **🗄 Start the MariaDB Database**:

    ```sh
    docker compose up -d mariadb
    ```

5. **🔧 Initialise the Databases**: Run `stage3.sh`.

    ```sh
    chmod +x stage3.sh
    ./stage3.sh
    ```

6. **📈 Bring Up the Rest of the Compose Stack**:

    ```sh
    docker compose up -d
    ```
    
7. **🦊 Configure Firefox**:

#### Configure Firefox Desktop

- Go to `about:config` in Firefox.
- Set `identity.sync.tokenserver.uri` to `http://TAILSCALE_IP:8000/1.0/sync/1.5`.

#### Configure Firefox Android

- Open the Firefox for Android menu.
- Tap `Settings`.
- Tap `About Firefox`.
- Tap the Firefox icon 5 times.
- Go back.
- Tap `Sync Debug`.
- Tap `Custom Mozilla account server` and enter your content server `http://TAILSCALE_IP:8000`.
- Tap `Custom Sync server` and enter your sync server URL `http://TAILSCALE_IP:8000/token/1.0/sync/1.5`.
- Tap `X` to stop Firefox that appeared in the menu. The server changes will take effect when you run Firefox again.

### 🚀 Now sync Firefox!

## 🤝 Contributing

We welcome contributions! Please open an issue or submit a pull request with your improvements.

## 📝 Acknowledgements

Originally based on [mozilla-services/syncstorage-rs](https://github.com/mozilla-services/syncstorage-rs) and with help from [dan-r's syncstorage-rs-docker](https://github.com/dan-r/syncstorage-rs-docker).

Special thanks to all contributors!
