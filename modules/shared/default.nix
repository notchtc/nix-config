{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) enum nullOr;
in
{
  options.mama = {
    desktop = mkOption {
      type = nullOr (enum [
        "gnome"
        "plasma"
      ]);
    };

    profiles = {
      graphical.enable = mkEnableOption "Graphical environment";
      laptop.enable = mkEnableOption "Laptop";
      server.enable = mkEnableOption "Server";

      gaming.enable = mkEnableOption "Gaming";
    };
  };
}
