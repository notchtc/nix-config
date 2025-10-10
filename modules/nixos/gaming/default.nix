{ config, lib, ... }:
let
  inherit (lib) mkEnableOption;
  cfg = config.mama.programs.gaming;
in
{
  options.mama.programs.gaming = {
    enable = mkEnableOption ''
      All the gaming software I need
    '';

    gamemode.enable = mkEnableOption "Gamemode" // {
      default = cfg.enable;
    };
    gamescope.enable = mkEnableOption "Gamescope" // {
      default = cfg.enable;
    };
    #    openmw.enable = mkEnableOption "OpenMW" // {
    #      default = cfg.enable;
    #    };
    lutris.enable = mkEnableOption "OpenMW" // {
      default = cfg.enable;
    };
    steam.enable = mkEnableOption "OpenMW" // {
      default = cfg.enable;
    };
  };

  imports = [
    ./gamemode.nix
    ./gamescope.nix
    #    ./openmw.nix
    ./lutris.nix
    ./steam.nix
  ];
}
