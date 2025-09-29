{
  imports = [ ./disko.nix ];

  mama = {
    profiles = {
      graphical.enable = true;
      laptop.enable = true;
    };
    desktops.niri.enable = true;
    programs.gaming.enable = true;
  };

  home-manager.users.chtc = {
    mama.programs.foot.enable = true;
  };

  boot = {
    initrd.kernelModules = [ "dm-snapshot" ];
    kernelModules = [ "kvm-intel" ];
  };

  services = {
    undervolt = {
      enable = true;
      coreOffset = -119;
    };
    displayManager.autoLogin.user = "chtc";
  };

  networking.hostName = "dorothy";
  system.stateVersion = "25.11";
}
