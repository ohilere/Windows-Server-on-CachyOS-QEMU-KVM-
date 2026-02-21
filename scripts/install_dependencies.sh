#!/bin/bash

echo "-------------------------------------------------------"
echo "Step 1: Installing QEMU and Virtualization Dependencies"
echo "-------------------------------------------------------"

# Installing the full stack for CachyOS/Arch
sudo pacman -S --needed qemu-full virt-manager libvirt dnsmasq iptables-nft virt-viewer vde2


echo "Step 2: Configuring User Permissions"

# Adding the current user to libvirt and kvm groups
sudo usermod -aG libvirt,kvm $USER

echo "Done! IMPORTANT: You must log out and log back in for group changes to take effect."
