{
  home.sessionVariables = {
    TERMINAL = "foot";
  };

  programs.foot = {
    enable = true;

    settings = {
      main = {
        dpi-aware = "yes";
        pad = "3x3 center";
      };

      cursor = {
        style = "beam";
        blink = "yes";
      };
    };
  };
}
