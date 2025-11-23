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
  config = mkIf (graphical && desktop != "gnome") {
    home.sessionVariables.TERMINAL = "${pkgs.foot}/bin/footclient";
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "monospace:size=10";
          pad = "3x3 center";
        };

        cursor = {
          blink = "yes";
          style = "beam";
        };

        colors = {
          cursor = "002b36 93a1a1";
          background = "002b36";
          foreground = "839496";
          regular0 = "073642";
          regular1 = "dc322f";
          regular2 = "859900";
          regular3 = "b58900";
          regular4 = "268bd2";
          regular5 = "d33682";
          regular6 = "2aa198";
          regular7 = "eee8d5";
          bright0 = "002b36";
          bright1 = "cb4b16";
          bright2 = "586e75";
          bright3 = "657b83";
          bright4 = "839496";
          bright5 = "6c71c4";
          bright6 = "93a1a1";
          bright7 = "fdf6e3";
        };

        bell.system = "no";
        scrollback.lines = 1024 * 1024;
      };
    };
  };
}
