{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.mama = {
    desktops = {
      gnome.enable = mkEnableOption "Gnome";
      niri.enable = mkEnableOption "Niri";
    };
    profiles = {
      graphical.enable = mkEnableOption "Graphical environment";
      laptop.enable = mkEnableOption "Laptop";
      server.enable = mkEnableOption "Server";
    };
  };
}
