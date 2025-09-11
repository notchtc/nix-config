{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkOption;
  cfg = config.mama.system.ephemeral;
in
{
  imports = [ "${inputs.preservation.result}/module.nix" ];

  options.mama.system.ephemeral = {
    enable = mkEnableOption ''
      Rollback / to a pristine state.
    '';

    extraDirectories = mkOption {
      default = [ ];
      description = ''
        Additional directories to persist.
      '';
    };

    extraFiles = mkOption {
      default = [ ];
      description = ''
        Additional files to persist.
      '';
    };
  };

  config = mkIf cfg.enable {
    preservation = {
      enable = true;
      preserveAt."/persist" = {
        directories = [
          "/etc/NetworkManager/system-connections"
          "/var/lib/bluetooth"
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
        ]
        ++ cfg.extraDirectories;

        files = cfg.extraFiles;
      };
    };

    age.identityPaths = [
      "/persist/etc/ssh/ssh_host_ed25519_key"
      "/persist/etc/ssh/ssh_host_rsa_key"
    ];

    fileSystems = {
      "/persist".neededForBoot = true;
      "/var/log".neededForBoot = true;
    };

    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = [ "initrd.target" ];

      requires = [ "dev-mapper-pool\\x2droot.device" ];
      after = [ "dev-mapper-pool\\x2droot.device" ];

      before = [ "sysroot.mount" ];

      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        MNTPOINT=$(mktemp -d)

        mount -t btrfs -o subvol=/ /dev/mapper/pool-root "$MNTPOINT"
        trap 'umount "$MNTPOINT"; rm -rf "$MNTPOINT"' EXIT

        btrfs subvolume delete -R "$MNTPOINT/root"
        btrfs subvolume snapshot "$MNTPOINT/root-blank" "$MNTPOINT/root"
      '';
    };
  };
}
