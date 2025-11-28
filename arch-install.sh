#!/bin/bash
# TODO more logs
# TODO check inputs

echo "THIS SCRIPT MUST RUN AFTER PARTITIONING AND MOUNTING"

pacstrap -K /mnt base linux linux-firmware neovim git sway foot firefox eza fd fzf ripgrep networkmanager brightnessctl grub os-prober efibootmgr sudo
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

read -p "Area/Location: " localtime
ln -sf /usr/share/zoneinfo/$localtime /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=es" >> /etc/vconsole.conf

read -p "hostname: " hostname
echo $hostname >> /etc/hostname
echo "127.0.1.1        $hostname" >> /etc/hosts

passwd
read -p "user: " user
useradd -mG wheel $user
passwd $user

# TODO visudo

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/defaul/grub
os-prober
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

echo "Finish."
echo "You are still in arch-chroot!"
