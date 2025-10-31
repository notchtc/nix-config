{ config, lib, ... }:
let
  inherit (config.mama) desktop;
in
{
  programs.ghostty = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;
    settings = {
      cursor-style = "bar";
      font-family = "Sarasa Term J";
      font-size = 11;
      theme =
        if desktop == "gnome" then
          "dark:Adwaita Dark,light:Adwaita Dark"
        else if desktop == "plasma" then
          "dark:Breeze,light:Ayu Light"
        else
          "dark:Gruvbox Dark Hard,light:Gruvbox Light Hard";
      window-padding-x = 3;
      window-padding-y = 3;
      window-theme = "ghostty";

      scrollback-limit = 100 * 1024 * 1024;
      mouse-hide-while-typing = true;
    };
  };
}
