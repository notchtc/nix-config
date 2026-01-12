{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.bottles.enable = lib.mkEnableOption "Bottles" // {
    default = gaming.enable;
  };

  config.environment.systemPackages = lib.mkIf gaming.gamescope.enable [
    (pkgs.bottles.override { removeWarningPopup = true; })
  ];
}
