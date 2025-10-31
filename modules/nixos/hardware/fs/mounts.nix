{
  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=2G"
        "mode=755"
      ];
    };
    "/boot" = {
      fsType = "vfat";
      options = [ "defaults" ];
    };
    "/etc/ssh".neededForBoot = true;
  };
}
