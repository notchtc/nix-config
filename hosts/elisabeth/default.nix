{
  mama = {
    profiles = {
      graphical.enable = true;
      laptop.enable = true;
    };
    desktops.gnome.enable = true;
    programs.gaming.enable = true;
    system = {
      ephemeral.enable = true;
      secure-boot.enable = true;
    };
  };
  home-manager.users.chtc.mama.programs.ghostty.enable = true;

  boot.kernelModules = [ "kvm-amd" ];

  services = {
    displayManager.autoLogin.user = "chtc";
    fwupd.enable = true;
  };

  hardware.nvidia = {
    open = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  fileSystems."/boot".device = "/dev/disk/by-uuid/E832-2DAC";
  networking.hostName = "elisabeth";
  system.stateVersion = "25.11";
}
