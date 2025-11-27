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
  options.mama.profiles.gaming.lutris.enable = lib.mkEnableOption "Lutris" // {
    default = gaming.enable;
  };

  config.environment.systemPackages = lib.mkIf gaming.lutris.enable [ pkgs.lutris ];
}
