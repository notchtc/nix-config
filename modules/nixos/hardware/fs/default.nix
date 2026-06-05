{ config, ... }:
{
  imports = [
    ./mounts.nix
    ./services.nix
  ];

  boot = {
    bcache.enable = false;
    supportedFilesystems = [ "zfs" ];
    zfs.package = config.boot.kernelPackages.zfs_cachyos;
  };
}
