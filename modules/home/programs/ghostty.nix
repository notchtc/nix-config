{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (config.mama) desktop;
  graphical = config.mama.profiles.graphical.enable;
in
{
  config = mkIf (graphical && desktop == "gnome") {
    home.sessionVariables.TERMINAL = "${pkgs.ghostty}/bin/ghostty";
    programs.foot = {
      enable = true;
      settings = {
        cursor-style = "bar";
        font-family = "Iosevka Term";
        font-size = 10;
        theme = "Builtin Solarized Light";
        window-padding-x = 3;
        window-padding-y = 3;
        window-theme = "ghostty";

        scrollback-limit = 100 * 1024 * 1024;
        mouse-hide-while-typing = true;
      };
    };
  };
}
