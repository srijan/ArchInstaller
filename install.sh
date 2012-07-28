#!/bin/sh

# Variables
PACKAGES="dnsutils elinks htop mlocate net-tools openssh openssl rsync tmux vim"

echo "###########################   Disk Setup   ###########################"
parted -m -s /dev/sda print | awk -F : '{print $1}' | grep "^[1-9]$" | xargs -L1 parted /dev/sda -s rm      # deletes all partitions
fdisk /dev/sda < fdisk_in.txt

mkfs.ext2 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

echo "###########################   Copying Packages   ###########################"
mkdir -p /mnt/var/cache/pacman/pkg/
mv pkg/* /mnt/var/cache/pacman/pkg/

echo "###########################   Installing Packages   ###########################"
pacstrap /mnt base base-devel
pacstrap /mnt grub-bios
pacstrap /mnt $PACKAGES

genfstab -U -p /mnt >> /mnt/etc/fstab

cp inside.sh /mnt/
cp conf/rc.conf /mnt/etc/

echo "###########################   Entering Chroot   ###########################"
arch-chroot /mnt /bin/bash inside.sh

echo "###########################   Unmounting   ###########################"
umount /mnt/boot/
umount /mnt
echo "###########################   Installation Complete   ###########################"
