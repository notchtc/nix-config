```
BOOT=/dev/disk/by-id/nvme-Micron_MTFDKCD512QGN-1BN1AABLA_25144F2F96CF-part1
DISK=/dev/disk/by-id/nvme-Micron_MTFDKCD512QGN-1BN1AABLA_25144F2F96CF-part2
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

zfs create -o canmount=off -o mountpoint=/ elisabeth/NixOS
zfs create -o canmount=on -o mountpoint=/persist elisabeth/NixOS/persist
zfs create -o canmount=on -o mountpoint=/home elisabeth/NixOS/home
zfs create -o canmount=on -o mountpoint=/nix -o com.sun:auto-snapshot=false elisabeth/NixOS/nix
zfs create -o mountpoint=none elisabeth/NixOS/var
zfs create -o canmount=on -o mountpoint=/var/log elisabeth/NixOS/var/log
zfs create -o canmount=on -o mountpoint=/var/lib elisabeth/NixOS/var/lib

mkdir -p /mnt
mount -t tmpfs none /mnt

mkdir -p /mnt/{boot,persist,home,nix,var/log,var/lib}
mount -t zfs elisabeth/NixOS/persist /mnt/persist -o zfsutil
mount -t zfs elisabeth/NixOS/home /mnt/home -o zfsutil
mount -t zfs elisabeth/NixOS/nix /mnt/nix -o zfsutil
mount -t zfs elisabeth/NixOS/var/log /mnt/var/log -o zfsutil
mount -t zfs elisabeth/NixOS/var/lib /mnt/var/lib -o zfsutil

mkfs.fat -F 32 -n boot "$BOOT"
mount "$BOOT" /mnt/boot
```
