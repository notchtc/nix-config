{
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
  };
}
