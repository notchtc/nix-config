{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
    ./services.nix
  ];

  boot = {
    bcache.enable = false;
    supportedFilesystems = [ "zfs" ];
    zfs.package = pkgs.zfs_unstable;
  };
}
