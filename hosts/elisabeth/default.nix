{
  mama = {
    desktop = "plasma";
    hardware = {
      cpu = "amd";
      gpu = [
        "amd"
        "nvidia"
      ];
    };
    profiles = {
      gaming.enable = true;
      graphical.enable = true;
      laptop.enable = true;
    };
    system.secure-boot.enable = true;
  };

  boot.kernelParams = [ "amdgpu.sg_display=0" ];

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    amdgpuBusId = "PCI:5:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  fileSystems."/boot".device = "/dev/disk/by-uuid/E832-2DAC";
  system.stateVersion = "25.11";
}
