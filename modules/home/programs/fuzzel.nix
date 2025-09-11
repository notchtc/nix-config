{ config, lib, ... }:
{
  programs.fuzzel = lib.mkIf config.mama.desktops.niri.enable {
    enable = true;
    settings = {
      main = {
        icon-theme = "MoreWaita";
        horizontal-pad = 6;
        prompt = "\"λ \"";
        vertical-pad = 6;
      };
      border = {
        width = 2;
        radius = 6;
      };
    };
  };
}
