{
  boot = {
    blacklistedKernelModules = [
      "iTCO_wdt"
      "sp5100_tco"
    ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };
    kernelParams = [
      "nowatchdog"
    ];
  };
}
