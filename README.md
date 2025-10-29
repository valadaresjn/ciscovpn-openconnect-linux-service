# OpenConnect VPN Script

This project provides a **lightweight shell script** to connect, disconnect, and manage a **Cisco AnyConnect-compatible VPN** using the [`openconnect`](https://www.infradead.org/openconnect/) command-line client.  
It’s designed for Linux systems that lack native GUI integration for Cisco VPN connections.

---

## Requirements

- Linux system with `systemd`
- `openconnect` installed

```bash
sudo apt install openconnect -y
```

---

## Installation & Setup

The easiest way to install and configure this VPN script is by using the provided **Quick Setup Script** located in the parent directory of the repository.

### 1. Clone or download the repository
```bash
git clone https://github.com/valadaresjn/ciscovpn-openconnect-linux-service.git
cd ciscovpn-openconnect-linux-service
```

### 2. Run the setup script
Make sure you’re in the parent directory that contains both the `setup-openconnect.sh` script and the `openconnect-vpn` file, then run:

```bash
chmod +x ../setup-openconnect.sh
../setup-openconnect.sh
```

This will:
- Copy the VPN script to `/usr/local/bin/openconnect-vpn`
- Make it executable
- Create and enable a `systemd` service automatically

After setup completes, you’ll see usage instructions printed in the terminal.

---

## Configuration

Edit the script `/usr/local/bin/openconnect-vpn` and set your VPN connection details:

```bash
VPN_SERVER="your.vpn.server"
VPN_GROUP="GroupName"
VPN_USER="username"
```

Optionally, configure secure password storage as described in the [Security](#-security) section.

---

# Reload and enable service
sudo systemctl daemon-reload
sudo systemctl enable openconnect-vpn.service

echo "✅ Installation complete!"
echo "Use the following commands:"
echo "  sudo systemctl start openconnect-vpn"
echo "  sudo systemctl status openconnect-vpn"
echo "  sudo systemctl stop openconnect-vpn"
```

---

## Usage

After installation, you can manage the VPN connection either directly with the script or using systemd commands.

### Script commands:
```bash
sudo openconnect-vpn start
sudo openconnect-vpn status
sudo openconnect-vpn stop
```

### System service commands:
```bash
sudo systemctl start openconnect-vpn
sudo systemctl status openconnect-vpn
sudo systemctl stop openconnect-vpn
```

---

## Security

You can avoid entering your VPN password each time by using one of these methods:

### Option 1 — Password file (restricted permissions)
```bash
echo "your_password" > ~/.vpn-pass
chmod 600 ~/.vpn-pass
```

Then modify the script to include:
```bash
--passwd-on-stdin < ~/.vpn-pass
```

### Option 2 — Keyring or password manager
Integrate with tools like `secret-tool` or `pass` for secure credential storage.

---

## Troubleshooting

- View logs:
  ```bash
  journalctl -u openconnect-vpn.service -f
  ```
- Check if DNS/routing is correctly handled by the VPN (`/etc/resolv.conf`).
- Disconnect all active VPN sessions:
  ```bash
  sudo pkill openconnect
  ```

---

## License

This project is licensed under the **GNU General Public License v2.0 (GPL-2.0)**.  
See the [LICENSE](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) file or visit  
[https://www.gnu.org/licenses/old-licenses/gpl-2.0.html](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) for more details.