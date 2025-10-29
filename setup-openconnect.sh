#!/bin/bash
# Quick setup for OpenConnect VPN script + systemd service

set -e

echo "🚀 Installing OpenConnect VPN script..."

# Copy script
sudo cp openconnect-vpn /usr/local/bin/
sudo chmod +x /usr/local/bin/openconnect-vpn

# Create systemd service
cat << 'EOF' | sudo tee /etc/systemd/system/openconnect-vpn.service > /dev/null
[Unit]
Description=OpenConnect VPN (Cisco AnyConnect)
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/bin/openconnect-vpn start
ExecStop=/usr/local/bin/openconnect-vpn stop
PIDFile=/var/run/openconnect.pid
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

# Reload and enable service
sudo systemctl daemon-reload
sudo systemctl enable openconnect-vpn.service

echo "✅ Installation complete!"
echo "Use the following commands:"
echo "  sudo systemctl start openconnect-vpn"
echo "  sudo systemctl status openconnect-vpn"
echo "  sudo systemctl stop openconnect-vpn"
