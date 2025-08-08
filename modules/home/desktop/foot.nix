{
  home.sessionVariables.TERMINAL = "foot";
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        pad = "6x6 center";
      };

      cursor = {
        style = "beam";
        blink = "yes";
      };
    };
  };
}
