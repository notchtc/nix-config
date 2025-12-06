{
  mama = {
    hardware = {
      autoaspm = true;
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

  systemd.tmpfiles.settings = {
    "enable-conservation-mode" = {
      "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode" = {
        "f+" = {
          group = "root";
          user = "root";
          mode = "0644";
          argument = "1";
        };
      };
    };
  };

  fileSystems."/boot".device = "/dev/disk/by-uuid/E832-2DAC";
  system.stateVersion = "25.11";
}
