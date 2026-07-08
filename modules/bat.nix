{
  config.modules.nixos.bat = {
    programs.bat = {
      enable = true;

      settings = {
        pager = "'moor -no-linenumbers'";
        theme = "gruvbox-dark";
      };
    };
  };
}
