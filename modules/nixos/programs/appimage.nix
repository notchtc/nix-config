{ config, lib, ... }:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
in
{
  programs.appimage = mkIf graphical {
    enable = true;
    binfmt = true;
  };
}
