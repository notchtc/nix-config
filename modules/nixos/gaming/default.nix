{ config, lib, ... }:
let
  inherit (lib) mkIf;
  gaming = config.mama.profiles.gaming.enable;
in
{
  imports = [
    ./gamemode.nix
    ./gamescope.nix
    ./openmw.nix
    ./lutris.nix
    ./steam.nix
  ];

  boot.kernel.sysctl = mkIf gaming { "kernel.split_lock_mitigate" = 0; };
}
