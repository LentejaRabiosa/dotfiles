#!/bin/bash
echo "ARCH INSTALL SCRIPT"

pacstrap -K /mnt base linux linux-firmware sudo
genfstab -U /mnt > /mnt/etc/fstab
cat arch-post-install.sh | arch-chroot /mnt /bin/bash

echo "INSTALL COMPLETE"
