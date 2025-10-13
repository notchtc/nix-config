{
  imports = [ ./disko.nix ];

  mama = {
    profiles = {
      gaming.enable = true;
      graphical.enable = true;
      laptop.enable = true;
    };
    desktops.niri.enable = true;
  };

  home-manager.users.chtc = {
    mama.programs.foot.enable = true;
  };

  boot.initrd.kernelModules = [ "dm-snapshot" ];

  services.undervolt = {
    enable = true;
    coreOffset = -119;
  };

  system.stateVersion = "25.11";
}
