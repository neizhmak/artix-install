#!/bin/sh

# format disk
 mkfs.ext4 -L ROOT /dev/sda1
 mkfs.ext4 -L HOME /dev/sda2

# mount disk
 mount /dev/disk/by-label/ROOT /mnt
 mkdir /mnt/home
 mount /dev/disk/by-label/HOME /mnt/home

# install system
 basestrap /mnt filesystem gcc-libs glibc bash coreutils file findutils gawk grep procps-ng sed tar gettext pciutils \
 psmisc shadow util-linux bzip2 gzip xz licenses pacman artix-keyring seatd-dinit esysusers etmpfiles iputils \
 iproute2 dinit linux linux-firmware grub os-prober dhcpcd wpa_supplicant wpa_supplicant-dinit
 
 fstabgen -U /mnt >> /mnt/etc/fstab
 cp /2-installer.sh /mnt/
 artix-chroot /mnt /2-installer.sh

# finish up
 umount -R /mnt
 poweroff
