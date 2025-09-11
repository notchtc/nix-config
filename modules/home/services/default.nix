{ config, lib, ... }:
{
  imports = [
    ./swayidle.nix
    ./swaync.nix
    ./wlsunset.nix
  ];
  services.playerctld.enable = lib.mkIf config.mama.profiles.graphical.enable true;
}
