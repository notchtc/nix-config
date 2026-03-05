{ lib, profiles, ... }:
{
  config = lib.mkIf profiles.graphical.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        theme = "Adwaita Dark";
        cursor-style = "bar";
        window-padding-x = 3;
        window-padding-y = 3;
        window-theme = "ghostty";

        scrollback-limit = 100 * 1024 * 1024;
        shell-integration = "none";
        mouse-hide-while-typing = true;
        quit-after-last-window-closed = false;
      };
    };
  };
}
