{
  programs.plasma.window-rules = [
    {
      description = "Schizofox";
      match = {
        window-class = {
          value = "firefox";
          type = "exact";
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
