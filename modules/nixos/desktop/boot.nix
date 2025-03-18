{ lib, pkgs, ... }:
{
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod;
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };
  };
}
