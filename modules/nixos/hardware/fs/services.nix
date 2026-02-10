{
  services = {
    lvm.enable = false;
    zfs = {
      autoScrub.enable = true;

      autoSnapshot = {
        enable = true;
        flags = "-kpu";
        monthly = 2;
      };
    };
  };

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
