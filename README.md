# Ansible playbook for building an OS image

I always wanted to be able to customize and add to Arch Linux embedded installs.

The goal here is to have a set of playbooks that generates a storage medium
that's supposed to boot and already be usable for a particular application
(ex: the alarm setup for my [guitar](https://hypertriangle.com/~alex/guitar/),
or [MiSTerArch](https://github.com/MiSTerArch)).

## Distro

The scripts themselves can be a little neutral to what distro is
setup. This project started by targeting [Arch Linux ARM](https://archlinuxarm.org/),
but it has since expanded to Arch's riscv and x86.

It can also be expanded to support Fedora and Debian systems. The main
requirements for adding a new distro is for it to be manually
installable (ideally by the ability to download a raw rootfs, and the
distro not wanting to take over and stomp over the partitioning and bootloader).

## Dependencies

* [Ansible](https://docs.ansible.com/ansible/latest/)
* If a foreign architecture is used: qemu-user-static in order to
  [chroot from x86 into it](https://wiki.archlinux.org/title/QEMU#Chrooting_into_arm/arm64_environment_from_x86_64).
* [arch-chroot](https://man.archlinux.org/man/arch-chroot.8) in $PATH from
  package [arch-install-scripts](https://archlinux.org/packages/extra/any/arch-install-scripts/).
  This is used for non arch distros too.

### Arch Linux

```bash
pikaur -S ansible arch-install-scripts qemu-user-static qemu-user-static-binfmt
```

### Debian

```bash
sudo apt-get install ansible arch-install-scripts qemu-user-static
```

## How to run

Define your inventory (at least for the machine settings), see
inventory_template.yml for more details on how or where to put them.

```bash
ansible-os-builder% sudo ansible-playbook -i inventory.yml *.play*.yml -v
```

### Tags

After the first successful run, you can probably narrow the `--tags` you're
running, some might be desired to be ran standalone. You can also `--skip-tags`.
`--list-tags` will give you a complete list of how plays are tagged.
Some tags of interest:

* `chroot_aquire` - creates chroot. It won't clobber it if already there,
  but should be skipped in order to save time if it is.
* `chroot_inventory` - if you already have a chroot setup, this is required
  (add as the first task in the arguments) to add the "chroot" host to the ram
  based inventory so other tasks can operate on it.
* `update` - various updates: arch packages
