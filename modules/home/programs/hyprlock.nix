{ config, lib, ... }:
{
  programs.hyprlock.enable = lib.mkIf config.mama.desktops.niri.enable true;
}
