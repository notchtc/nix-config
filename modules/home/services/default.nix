{ config, lib, ... }:
{
  imports = [ ./easyeffects ];

  services.playerctld.enable = lib.mkIf config.mama.profiles.graphical.enable true;
}
