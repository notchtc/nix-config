{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    systemd.user.services.niri-flake-polkit.enable = false;
    security.soteria.enable = true;
  };
}
