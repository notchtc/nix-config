{
  inputs,
  flake,
  lib,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    flake.nixosModules.desktop
    flake.nixosModules.laptop
    flake.nixosModules.vaapi
    flake.nixosModules.gaming
    flake.nixosModules.user-chtc
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "dorothy";

  systemd.services.ModemManager.enable = lib.mkForce false;

  services.undervolt = {
    enable = true;
    coreOffset = -100;
  };

  fonts.fontconfig = {
    antialias = true;
    cache32Bit = true;
    hinting = {
      enable = true;
      autohint = true;
    };
    subpixel.rgba = "rgb";
  };

  services.displayManager.autoLogin.user = "chtc";
}
