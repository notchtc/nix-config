```
BOOT=/dev/disk/by-id/nvme-Micron_MTFDKCD512QGN-1BN1AABLA_25144F2F96CF-part1
DISK=/dev/disk/by-id/nvme-Micron_MTFDKCD512QGN-1BN1AABLA_25144F2F96CF-part2

mkdir -p /mnt/boot
mount -t tmpfs none /mnt

mkfs.fat -F 32 -n boot "$BOOT"
mount "$BOOT" /mnt/boot

zpool create -f \
  -o ashift=12 \
  -O acltype=posixacl \
  -O atime=off \
  -O checksum=blake3 \
  -O compression=zstd \
  -O devices=off \
  -O dnodesize=auto \
  -O normalization=formD \
  -O utf8only=on \
  -O xattr=sa \
  -O com.sun:auto-snapshot=true \
  -O encryption=aes-256-gcm \
  -O keyformat=passphrase \
  -O keylocation=prompt \
  -R /mnt \
  -O mountpoint=none \
  elisabeth \
  "$DISK"

zfs create -o canmount=off elisabeth/NixOS
zfs create -o canmount=on elisabeth/NixOS/home
zfs create -o canmount=off elisabeth/NixOS/etc
zfs create -o canmount=on elisabeth/NixOS/etc/NetworkManager
zfs create -o canmount=on elisabeth/NixOS/etc/ssh
zfs create -o canmount=on -o com.sun:auto-snapshot=false elisabeth/NixOS/nix
zfs create -o canmount=off elisabeth/NixOS/var
zfs create -o canmount=on elisabeth/NixOS/var/log
zfs create -o canmount=on elisabeth/NixOS/var/lib

mkdir -p /mnt/{etc/ssh,etc/NetworkManager,home,nix,var/log,var/lib}
mount -t zfs elisabeth/NixOS/etc/ssh /mnt/etc/ssh -o zfsutil
mount -t zfs elisabeth/NixOS/etc/NetworkManager /mnt/etc/NetworkManager -o zfsutil
mount -t zfs elisabeth/NixOS/home /mnt/home -o zfsutil
mount -t zfs elisabeth/NixOS/nix /mnt/nix -o zfsutil
mount -t zfs elisabeth/NixOS/var/log /mnt/var/log -o zfsutil
mount -t zfs elisabeth/NixOS/var/lib /mnt/var/lib -o zfsutil
```
