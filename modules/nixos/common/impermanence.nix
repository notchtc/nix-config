{ inputs, ... }:
{
  imports = [ "${inputs.impermanence.result}/nixos.nix" ];

  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
  };

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
    ];
  };

  age.identityPaths = [
    "/persist/etc/ssh/ssh_host_ed25519_key"
    "/persist/etc/ssh/ssh_host_rsa_key"
  ];

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
}
