{
  config.modules.nixos.storage =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib.attrsets) genAttrs;
      inherit (lib.strings) optionalString versionOlder;
      inherit (lib.asserts) assertMsg;
    in
    {
      boot = {
        supportedFilesystems = [ "zfs" ];

        zfs.modulePackage =
          assert assertMsg (versionOlder pkgs.zfs.version "2.4.4") "ZFS override no longer needed";
          config.boot.kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.overrideAttrs (prev: {
            configureFlags = (prev.configureFlags or [ ]) ++ [ "--enable-linux-experimental" ];

            meta = prev.meta // {
              broken = false;
            };
          });
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
            "huge=within_size"
            "mode=755"
            "size=1G"
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
