{
  home.sessionVariables.TERMINAL = "ghostty";
  programs.ghostty = {
    enable = true;
    settings = {
      cursor-style = "bar";
      gtk-single-instance = true;
      window-padding-x = 6;
      window-padding-y = 6;
      window-theme = "ghostty";
    };
  };
}
