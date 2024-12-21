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

  boot.initrd = {
    availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
  };

  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  nix.daemonCPUSchedPolicy = "idle";
}
