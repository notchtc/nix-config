{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  boot = {
    kernelParams = ["radeon.si_support=0" "radeon.cik_support=0" "amdgpu.si_support=1" "amdgpu.cik_support=1"];
    kernelModules = ["i915" "amdgpu"];
  };

  networking.hostName = "dorothy";

  systemd.services.ModemManager.enable = lib.mkForce false;

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
