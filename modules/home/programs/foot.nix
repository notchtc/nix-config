{ lib, osConfig, ... }:
{
  config = lib.mkIf osConfig.mama.profiles.graphical.enable {
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
          cursor = "103c48 53d6c7";
          background = "103c48";
          foreground = "adbcbc";

          regular0 = "184956";
          regular1 = "fa5750";
          regular2 = "75b938";
          regular3 = "dbb32d";
          regular4 = "4695f7";
          regular5 = "f275be";
          regular6 = "41c7b9";
          regular7 = "72898f";

          bright0 = "2d5b69";
          bright1 = "ff665c";
          bright2 = "84c747";
          bright3 = "ebc13d";
          bright4 = "58a3ff";
          bright5 = "ff84cd";
          bright6 = "53d6c7";
          bright7 = "cad8d9";
        };

        bell.system = "no";
        scrollback.lines = 1024 * 1024;
      };
    };
  };
}
