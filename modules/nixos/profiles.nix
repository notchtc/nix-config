{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.mama = {
    profiles = {
      graphical.enable = mkEnableOption "Graphical environment (Niri)";
      laptop.enable = mkEnableOption "Laptop";
      server.enable = mkEnableOption "Server";

      gaming.enable = mkEnableOption "Gaming";
    };
  };
}
