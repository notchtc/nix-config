{ config, lib, ... }:
{
  imports = [
    ./gamemode.nix
    ./gamescope.nix
    ./openmw.nix
    ./lutris.nix
    ./steam.nix
  ];

  boot.kernel.sysctl = lib.mkIf config.mama.profiles.gaming.enable {
    "kernel.split_lock_mitigate" = 0;
  };
}
