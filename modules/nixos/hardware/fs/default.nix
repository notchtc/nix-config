{
  imports = [
    ./mounts.nix
    ./preservation.nix
    ./zfs.nix
  ];

  boot.bcache.enable = false;
  services.lvm.enable = false;
}
