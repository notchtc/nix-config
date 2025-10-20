{
  host,
  lib,
  pkgs,
  ...
}:
{
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.package = pkgs.zfs_unstable;
  };

  services = {
    zfs = {
      autoScrub.enable = true;

      autoSnapshot = {
        enable = true;
        flags = "-kpu";
        monthly = 2;
      };
    };
  };

  fileSystems = lib.genAttrs [ "/persist" "/nix" "/var/log" "/var/lib" ] (fs: {
    device = "${host}/NixOS${lib.optionalString (fs != "/") fs}";
    fsType = "zfs";
    options = [ "zfsutil" ];
  });
}
