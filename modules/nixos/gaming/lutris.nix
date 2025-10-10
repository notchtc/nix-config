{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = lib.mkIf config.mama.programs.gaming.lutris.enable [ pkgs.lutris ];
}
