{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.programs.gaming.lutris.enable {
    environment.systemPackages = [ pkgs.lutris ];
  };
}
