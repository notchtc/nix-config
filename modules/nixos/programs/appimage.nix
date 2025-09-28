{ config, lib, ... }:
{
  programs.appimage = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;
    binfmt = true;
  };
}
