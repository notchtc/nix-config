{
  mama = {
    hardware = {
      cpu = "amd";
      gpu.gpus = [
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

  boot = {
    kernelParams = [ "amdgpu.sg_display=0" ];
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

  services.autoaspm.enable = true;

  fileSystems."/boot".device = "/dev/disk/by-uuid/E832-2DAC";
  system.stateVersion = "25.11";
}
