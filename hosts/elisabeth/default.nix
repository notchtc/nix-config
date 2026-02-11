{
  mama = {
    hardware = {
      cpu = "amd";
      gpus = [
        "amd"
        "nvidia"
      ];
    };
    profiles = {
      graphical.enable = true;
      laptop.enable = true;
    };
    programs = {
      openmw.enable = false;
      wine.enable = true;
    };
    system.secure-boot.enable = true;
  };

  boot = {
    kernel.sysfs.bus.platform.drivers.ideapad_acpi."VPC2004:00".conservation_mode = 1;

    initrd.availableKernelModules = [
      "nvme"
      "usbhid"
      "xhci_pci"
    ];
  };

  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:5:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  home-manager.users.chtc.programs.niri.settings = {
    outputs."eDP-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 144.003;
      };
      variable-refresh-rate = true;
    };
    debug.ignore-drm-device = "/dev/dri/renderD129";
  };

  fileSystems."/boot".device = "/dev/disk/by-uuid/E832-2DAC";
  system.stateVersion = "25.11";
}
