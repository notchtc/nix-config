{ config, lib, ... }:
{
  imports = [
    ./bottles.nix
    ./gamemode.nix
    ./gamescope.nix
    ./openmw.nix
    ./steam.nix
  ];

  boot = lib.mkIf config.mama.profiles.gaming.enable {
    kernelModules = [ "ntsync" ];
    kernel.sysctl."kernel.split_lock_mitigate" = 0;
  };
}
