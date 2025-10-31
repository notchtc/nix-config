{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.lutris.enable = mkEnableOption "Lutris" // {
    default = gaming.enable;
  };

  config.environment.systemPackages = mkIf gaming.lutris.enable [ pkgs.lutris ];
}
