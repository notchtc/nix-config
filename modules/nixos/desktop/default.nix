{
  flake,
  pkgs,
  ...
}:
{
  imports = [
    flake.nixosModules.common
    ./niri.nix
    ./pipewire.nix
    ./stylix.nix
  ];

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
    kernelParams = [ "nowatchdog" ];
  };

  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  nix.daemonCPUSchedPolicy = "idle";
}
