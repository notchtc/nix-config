{
  services = {
    lvm.enable = false;
    fstrim.enable = false;
    zfs = {
      autoScrub.enable = true;

      autoSnapshot = {
        enable = true;
        flags = "-kpu";
        monthly = 1;
      };
    };
  };

  systemd.services.zpool-trim = {
    unitConfig.ConditionACPower = true;

    serviceConfig = {
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };
}
