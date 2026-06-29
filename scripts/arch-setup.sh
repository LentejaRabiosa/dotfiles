#!/bin/bash
set -euo pipefail

error() {
    echo "$(basename "$0") failed"
    echo "line $1"
    echo "command $2"
}

trap 'error "$LINENO" "$BASH_COMMAND"' ERR

echo "arch setup script..."

read -rp "Area/Location: " localtime
ln -sf "/usr/share/zoneinfo/$localtime" /etc/localtime
hwclock --systohc

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=es" > /etc/vconsole.conf

read -rp "hostname: " hostname
echo "$hostname" > /etc/hostname
cat > /etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   $hostname.localdomain $hostname
EOF

passwd
read -rp "user: " user
useradd -mG wheel -s /bin/bash "$user"
passwd $user

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

awk 'NF' /root/packages.txt | xargs -r pacman -S --noconfirm --needed

# TODO: grub dir
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sed -i 's/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
os-prober
grub-mkconfig -o /boot/grub/grub.cfg

# TODO: system clock

systemctl enable NetworkManager

echo "arch setup completed"
