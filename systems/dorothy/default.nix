{ lib, system, ... }:
{
  imports = [
    ./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
    ];
    initrd.kernelModules = [ "dm-snapshot" ];
    kernelModules = [ "kvm-intel" ];
  };

  nixpkgs.hostPlatform = "${system}";

  services = {
    undervolt = {
      enable = true;
      coreOffset = -119;
    };
    displayManager.autoLogin.user = "chtc";
  };
  systemd.services.ModemManager.enable = lib.mkForce false;

  nix.settings.max-jobs = 4;
}
