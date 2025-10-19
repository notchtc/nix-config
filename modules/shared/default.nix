{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.mama = {
    desktops = {
      gnome.enable = mkEnableOption "Gnome";
      plasma.enable = mkEnableOption "Plasma";
    };
    profiles = {
      graphical.enable = mkEnableOption "Graphical environment";
      laptop.enable = mkEnableOption "Laptop";
      server.enable = mkEnableOption "Server";

      gaming.enable = mkEnableOption "Gaming";
    };
  };
}
