#!/bin/bash
# systemd-nspawn would be preferable, but ansible doesn't seem to play nice with it.
# https://man.archlinux.org/man/arch-chroot.8 is the next best thing

# Tip: you probably want to pair this with
# https://wiki.archlinux.org/title/QEMU#Chrooting_into_arm/arm64_environment_from_x86_64

chrootdir=$1; shift

if ! mountpoint -q "$chrootdir"; then
  # pacman expects a proper mount for /, even though we chroot
  mount -o bind "$chrootdir" "$chrootdir"
fi

# arch-chroot is available in the arch-install-scripts package,
# Including on debian!
arch-chroot "$chrootdir" "$@"
