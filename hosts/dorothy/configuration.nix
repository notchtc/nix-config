{ lib, ... }:
{
  imports = [
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

  environment.sessionVariables = {
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };

  system.stateVersion = "23.11";
}
