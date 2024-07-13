{
  home.sessionVariables = {
    TERMINAL = "foot";
  };

  programs = {
    foot = {
      enable = true;

      settings = {
        main = {
          font = "monospace:size=10";
          dpi-aware = "yes";
          pad = "3x3 center";
        };

        cursor = {
          style = "beam";
          blink = "yes";
        };

        colors = {
          background = "1d2021";
          foreground = "d4be98";
          regular0 = "32302f";
          regular1 = "ea6962";
          regular2 = "a9b665";
          regular3 = "d8a657";
          regular4 = "7daea3";
          regular5 = "d3869b";
          regular6 = "89b482";
          regular7 = "d4be98";
          bright0 = "32302f";
          bright1 = "ea6962";
          bright2 = "a9b665";
          bright3 = "d8a657";
          bright4 = "7daea3";
          bright5 = "d3869b";
          bright6 = "89b482";
          bright7 = "d4be98";
        };
      };
    };
  };
}
