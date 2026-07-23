{
  config.modules.nixos.zoxide = {
    programs.zoxide = {
      enable = true;
      flags = [ "--cmd cd" ];
    };
  };
}
