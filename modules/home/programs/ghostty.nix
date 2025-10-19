{ config, pkgs, ... }:
let
  cfg = config.mama.desktops;
in
{
  home.sessionVariables.TERMINAL = "${pkgs.ghostty}/bin/ghostty";
  programs.ghostty = {
    enable = true;
    settings = {
      cursor-style = "bar";
      font-family = "Sarasa Term J";
      font-size = 11;
      theme =
        if cfg.gnome.enable then
          "Adwaita Dark"
        else if cfg.plasma.enable then
          "Breeze"
        else
          "Gruvbox Dark Hard";
      window-padding-x = 3;
      window-padding-y = 3;
      window-theme = "ghostty";
    };
  };
}
