{
  config.modules.nixos.bat = {
    programs.bat = {
      enable = true;

      settings = {
        pager = "moor -no-line-numbers";
        theme = "gruvbox-dark";
      };
    };
  };
}
