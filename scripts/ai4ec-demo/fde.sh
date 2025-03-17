#!/bin/bash

cd "$(dirname "$0")"
source common.sh

# Prompt for FDE passphrase
echo -n "Enter password for FDE: "
read -s FDE_PASS
echo ""


[ -f "tpm2-fde.done" ] || {

$SSH_CMD << SSH_EOF
set -e

sudo apt-get update
sudo apt-get install -y tpm2-initramfs-tool
sudo tpm2-initramfs-tool seal --data "$FDE_PASS"

# edit /etc/crypttab, change "none" to "unseal", append keyscript=/usr/bin/tpm2-initramfs-tool
sudo sed -i -e 's#none#unseal#' /etc/crypttab
sudo sed -i -e 's#luks#luks,keyscript=/usr/bin/tpm2-initramfs-tool#' /etc/crypttab
# Add binaries and libraries to initramfs

cat << EOF | sudo tee /etc/initramfs-tools/hooks/tpm2-initramfs-tool
. /usr/share/initramfs-tools/hook-functions

copy_exec /usr/lib/x86_64-linux-gnu/libtss2-tcti-device.so.0
copy_exec /usr/bin/tpm2-initramfs-tool
EOF

sudo chmod 755 /etc/initramfs-tools/hooks/tpm2-initramfs-tool
sudo update-initramfs -u

SSH_EOF
touch tpm2-fde.done
}
