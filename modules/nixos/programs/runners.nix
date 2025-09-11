{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    programs = {
      nix-ld.enable = true;
      appimage = {
        enable = true;
        binfmt = true;
      };
    };
  };
}
