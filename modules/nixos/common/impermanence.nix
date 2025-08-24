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
      "/etc/nixos"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };

  age.identityPaths = [
    "/persist/etc/ssh/ssh_host_ed25519_key"
    "/persist/etc/ssh/ssh_host_rsa_key"
  ];

  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume to a pristine state";
    wantedBy = [ "initrd.target" ];

    after = [ "dev-mapper-pool\\x2droot.device" ];
    requires = [ "dev-mapper-pool\\x2droot.device" ];

    before = [ "sysroot.mount" ];

    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /mnt

      mount -t btrfs -o subvol=/root /dev/mapper/pool-root /mnt 
      trap 'umount /mnt; rm -rf /mnt' EXIT

      btrfs subvolume delete -R /mnt/root
      btrfs subvolume create /mnt/root
    '';
  };
}
