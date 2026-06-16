{ lib, pkgs, ... }: {
  boot = {
    kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;
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

  hjem.users.chtc.rum.desktops.niri.config = lib.mkAfter ''
    output "eDP-1" {
      mode "1920x1080@144.003000"
      variable-refresh-rate on-demand=false
    }
  '';

  fileSystems."/boot".device = "/dev/disk/by-uuid/E832-2DAC";

  hardware.enableRedistributableFirmware = true;
  services.ucodenix.cpuModelId = "00A70F52";

  networking.hostName = "elisabeth";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.11";
}
