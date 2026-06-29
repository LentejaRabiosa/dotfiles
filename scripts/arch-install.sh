#!/bin/bash
set -euo pipefail

error() {
    echo "$(basename "$0") failed"
    echo "line: $1"
    echo "command $2"
}

trap 'error "$LINENO" "$BASH_COMMAND"' ERR

echo "arch install script..."

pacstrap -K /mnt base linux linux-firmware sudo
genfstab -U /mnt > /mnt/etc/fstab
install -Dm755 arch-setup.sh /mnt/root/arch-setup.sh
install -Dm644 packages.txt /mnt/root/packages.txt
arch-chroot /mnt /root/arch-setup.sh
rm /mnt/root/arch-setup.sh

echo "arch install completed"
