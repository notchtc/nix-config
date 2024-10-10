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
