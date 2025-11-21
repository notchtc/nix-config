{
  host,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) genAttrs optionalString;
in
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

  fileSystems = genAttrs [ "/nix" "/persist" "/var/log" "/var/lib" ] (fs: {
    device = "${host}/NixOS${optionalString (fs != "/") fs}";
    fsType = "zfs";
    options = [ "zfsutil" ];
  });
}
