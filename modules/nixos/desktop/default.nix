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
    initrd = {
      blacklistedKernelModules = [
        "iTCO_wdt"
        "sp5100_tco"
      ];
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
