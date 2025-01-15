{
  programs.plasma.window-rules = [
    {
      description = "Schizofox";
      match = {
        window-class = {
          value = "firefox";
          type = "substring";
        };
      };
      apply = {
        desktopfile = {
          value = "Schizofox";
          apply = "force";
        };
      };
    }
  ];
}
