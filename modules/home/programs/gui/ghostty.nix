{ lib, profiles, ... }:
{
  programs.ghostty = lib.mkIf profiles.graphical.enable {
    enable = true;
    settings = {
      cursor-style = "bar";
      window-padding-x = 4;
      window-padding-y = 4;
      window-theme = "ghostty";

      scrollback-limit = 100 * 1024 * 1024;
      mouse-hide-while-typing = true;
    };
  };
}
