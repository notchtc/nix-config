{
  imports = [
    ./mounts.nix
    ./zfs.nix
  ];

  boot.bcache.enable = false;
  services.lvm.enable = false;

  systemd.services = {
    fstrim = {
      unitConfig.ConditionACPower = true;

      serviceConfig = {
        Nice = 19;
        IOSchedulingClass = "idle";
      };
    };
    zpool-trim = {
      unitConfig.ConditionACPower = true;

      serviceConfig = {
        Nice = 19;
        IOSchedulingClass = "idle";
      };
    };
  };
}
