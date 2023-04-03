#!/bin/sh

# time configuration
 ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
 hwclock --systohc

# locale configuration
 echo -e " en_US.UTF-8\n" >> /etc/locale.gen
 locale-gen
 echo -e " export LANG="en_US.UTF-8"\n export LC_COLLATE="C"\n" >> /etc/locale.conf

# grub configuration
 grub-install --recheck /dev/sda
 grub-mkconfig -o /boot/grub/grub.cfg

# user configuration
 passwd
 useradd -m user
 passwd user

# network configuration
 echo -e " desktop\n" >> /etc/hostname
 echo -e " 127.0.0.1        localhost\n ::1              localhost\n 127.0.1.1        desktop.localdomain  desktop\n" >> /etc/hosts

# repo configuration
 echo -e '
 [universe]
 Server = https://universe.artixlinux.org/$arch
 Server = https://mirror1.artixlinux.org/universe/$arch
 Server = https://mirror.pascalpuffke.de/artix-universe/$arch
 Server = https://artixlinux.qontinuum.space/artixlinux/universe/os/$arch
 Server = https://mirror1.cl.netactuate.com/artix/universe/$arch
 Server = https://ftp.crifo.org/artix-universe/$arch
 Server = https://artix.sakamoto.pl/universe/$arch

 [omniverse]
 Server = https://eu-mirror.artixlinux.org/omniverse/$arch
 Server = https://omniverse.artixlinux.org/$arch
 Server = https://artix.sakamoto.pl/omniverse/$arch' >> /etc/pacman.conf

 pacman -Syu artix-archlinux-support

 echo -e "
 [extra]
 Include = /etc/pacman.d/mirrorlist-arch

 [community]
 Include = /etc/pacman.d/mirrorlist-arch

 [multilib]
 Include = /etc/pacman.d/mirrorlist-arch" >> /etc/pacman.conf

 pacman-key --populate archlinux
 wget https://github.com/archlinux/svntogit-packages/raw/packages/pacman-mirrorlist/trunk/mirrorlist -O /etc/pacman.d/mirrorlist-arch

 pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
 pacman-key --lsign-key FBA220DFC880C036
 pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

 echo -e "
 [chaotic-aur]
 Include = /etc/pacman.d/chaotic-mirrorlist\n" >> /etc/pacman.conf

 pacman -Suy

# finish up
# exit
