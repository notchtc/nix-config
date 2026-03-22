{
  services = {
    lvm.enable = false;
    fstrim.enable = false;
    zfs.autoSnapshot.flags = "-kpu";
  };

  systemd.services.zpool-trim = {
    unitConfig.ConditionACPower = true;

    serviceConfig = {
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };
}
