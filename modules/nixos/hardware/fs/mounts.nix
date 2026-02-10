{ host, lib, ... }:
{
  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=1G"
        "mode=755"
      ];
    };

    "/boot" = {
      fsType = "vfat";
      options = [ "defaults" ];
    };

    "/var/lib".neededForBoot = true;
  }
  // lib.genAttrs [ "/nix" "/var/log" "/var/lib" ] (fs: {
    device = "${host}/NixOS${lib.optionalString (fs != "/") fs}";
    fsType = "zfs";
    options = [ "zfsutil" ];
  });
}
