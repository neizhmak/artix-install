#!/bin/sh

# format disk
mkfs.ext4 -L ROOT /dev/sda1
mkfs.ext4 -L HOME /dev/sda2

# mount disk
mount /dev/disk/by-label/ROOT /mnt
mkdir /mnt/home
mount /dev/disk/by-label/HOME /mnt/home

# install system
basestrap /mnt base seatd-dinit linux linux-firmware grub os-prober dhcpcd-dinit wpa_supplicant-dinit
 
fstabgen -U /mnt >> /mnt/etc/fstab
cp ./2-installer.sh /mnt/
chmod 777 /mnt/2-installer.sh
artix-chroot /mnt /2-installer.sh

# finish up
umount -R /mnt
poweroff
