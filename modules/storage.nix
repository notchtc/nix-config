{
  config.modules.nixos.tmp = {
    boot.tmp = {
      useTmpfs = true;
      tmpfsHugeMemoryPages = "within_size";
    };
  };

  config.modules.nixos.zfs =
    { config, lib, ... }:
    let
      inherit (lib) genAttrs optionalString;
    in
    {
      boot = {
        bcache.enable = false;
        supportedFilesystems = [ "zfs" ];
      };

      services = {
        fstrim.enable = false;
        lvm.enable = false;
        zfs.autoSnapshot.flags = "-kpu";
      };

      systemd.services.zpool-trim = {
        unitConfig.ConditionACPower = true;

        serviceConfig = {
          Nice = 19;
          IOSchedulingClass = "idle";
        };
      };

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
      // genAttrs [ "/nix" "/home" "/var/log" "/var/lib" ] (fs: {
        device = "${config.networking.hostName}/NixOS${optionalString (fs != "/") fs}";
        fsType = "zfs";
        options = [ "zfsutil" ];
      });
    };
}
