{
  home.sessionVariables = {
    TERMINAL = "foot";
  };

  programs.foot = {
    enable = true;

    settings = {
      main = {
        pad = "3x3 center";
      };

      cursor = {
        style = "beam";
        blink = "yes";
      };
    };
  };
}
