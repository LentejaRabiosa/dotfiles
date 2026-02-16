#!/bin/bash
echo "ARCH POST INSTALL SCRIPT (arch-chroot)"

read -p "Area/Location: " localtime
ln -sf /usr/share/zoneinfo/$localtime /etc/localtime
hwclock --systohc

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=es" > /etc/vconsole.conf

read -p "hostname: " hostname
sed -i "/127.0.1.1/d" /etc/hosts
echo "127.0.1.1        $hostname" >> /etc/hosts

passwd
read -p "user: " user
useradd -mG wheel -s /bin/bash $user
passwd $user

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

pacman -Sy --noconfirm
pacman -S --noconfirm neovim git sway sway-bg ly foot firefox fish fisher eza fd less fzf ripgrep networkmanager openssh brightnessctl grub os-prober efibootmgr ttf-jetbrains-mono-nerd

ssh-keygen -t ed25519 -C $hostname
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sed -i 's/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
os-prober
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable ly@tty1.service
systemctl disable getty@tty1.service

echo "POST INSTALL COMPLETE"
