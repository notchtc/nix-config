{
  config.modules.home.zoxide = {
    rum.programs.zoxide = {
      enable = true;
      flags = [ "--cmd cd" ];
      integrations.zsh.enable = true;
    };
  };
}
