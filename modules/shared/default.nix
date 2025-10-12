{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.mama = {
    desktops = {
      cosmic.enable = mkEnableOption "Cosmic";
      gnome.enable = mkEnableOption "Gnome";
    };
    profiles = {
      graphical.enable = mkEnableOption "Graphical environment";
      laptop.enable = mkEnableOption "Laptop";
      server.enable = mkEnableOption "Server";

      gaming.enable = mkEnableOption "Gaming";
    };
  };
}
