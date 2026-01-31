#!/bin/bash
# Setup script for macOS to enable passwordless powermetrics access

set -e

echo "=== gpulegion macOS Setup ==="
echo ""
echo "This script will configure passwordless sudo access for powermetrics."
echo "This is required for GPU monitoring on Apple Silicon."
echo ""

# Get current username
USERNAME=$(whoami)

# Create sudoers file
SUDOERS_FILE="/etc/sudoers.d/powermetrics"

echo "Creating sudoers configuration..."
echo "You will be prompted for your password once."
echo ""

# Create the sudoers entry
sudo tee "$SUDOERS_FILE" > /dev/null << EOF
# Allow $USERNAME to run powermetrics without password
$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/powermetrics
EOF

# Set correct permissions
sudo chmod 0440 "$SUDOERS_FILE"

echo ""
echo "✅ Setup complete!"
echo ""
echo "Testing powermetrics access..."
if sudo -n powermetrics --samplers gpu_power --sample-count 1 --sample-rate 100 > /dev/null 2>&1; then
    echo "✅ powermetrics is working!"
else
    echo "⚠️  powermetrics test failed. You may need to reboot."
fi

echo ""
echo "Now run: python3 example.py"
