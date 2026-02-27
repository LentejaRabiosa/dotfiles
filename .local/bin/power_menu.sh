#!/bin/bash

SELECTION="$(printf "Suspend\nReboot\nReboot to UEFI\nHard reboot\nShutdown" | fuzzel --dmenu -p "Power Menu: ")"

case $SELECTION in
    *"Suspend")
        systemctl suspend;;
    *"Reboot")
        systemctl reboot;;
    *"Reboot to UEFI")
        systemctl reboot --firmware-setup;;
    *"Hard reboot")
        pkexec "echo b > /proc/sysrq-trigger";;
    *"Shutdown")
        systemctl poweroff;;
esac
