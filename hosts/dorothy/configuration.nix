{
  inputs,
  flake,
  lib,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    flake.nixosModules.amdgpu
    flake.nixosModules.de-plasma
    flake.nixosModules.gaming
    flake.nixosModules.laptop
    flake.nixosModules.perlless
    flake.nixosModules.user-chtc
    ./disko.nix
  ];

  boot.initrd.kernelModules = [ "dm-snapshot" ];

  networking.hostName = "dorothy";
  nixpkgs.hostPlatform = "x86_64-linux";

  services = {
    undervolt = {
      enable = true;
      coreOffset = -119;
    };
    displayManager.autoLogin.user = "chtc";
  };
  systemd.services.ModemManager.enable = lib.mkForce false;

  nix.settings.max-jobs = 4;

  home-manager.users.chtc.imports = [ flake.homeModules.de-plasma ];
}
