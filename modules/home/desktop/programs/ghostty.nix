{
  home.sessionVariables.TERMINAL = "ghostty";
  xdg.terminal-exec.settings.default = [ "com.mitchellh.ghostty.desktop" ];
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
