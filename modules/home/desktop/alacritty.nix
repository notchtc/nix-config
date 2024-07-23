{
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = {
          x = 3;
          y = 3;
        };
        dynamic_padding = false;
      };

      font = {
        size = 10;
      };

      colors = {
        primary = {
          background = "#1d2021";
          foreground = "#d4be98";
        };
        normal = {
          black = "#32302f";
          red = "#ea6962";
          green = "#a9b665";
          yellow = "#d8a657";
          blue = "#7daea3";
          magenta = "#d3869b";
          cyan = "#89b482";
          white = "#d4be98";
        };
        bright = {
          black = "#32302f";
          red = "#ea6962";
          green = "#a9b665";
          yellow = "#d8a657";
          blue = "#7daea3";
          magenta = "#d3869b";
          cyan = "#89b482";
          white = "#d4be98";
        };
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        vi_mode_style = {
          shape = "Block";
        };
      };

      keyboard.bindings = [
        {
          key = "N";
          mods = "Control";
          action = "CreateNewWindow";
        }
      ];
    };
  };
}
