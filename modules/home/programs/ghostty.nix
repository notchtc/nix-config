{ lib, osConfig, ... }:
{
  programs.ghostty = lib.mkIf osConfig.mama.profiles.graphical.enable {
    enable = true;
    settings = {
      cursor-style = "bar";
      font-family = "monospace";
      font-size = 10;
      theme = "Rose Pine";
      window-padding-x = 3;
      window-padding-y = 3;
      window-theme = "system";

      scrollback-limit = 100 * 1024 * 1024;
      mouse-hide-while-typing = true;
    };
  };
}
