{
  config.modules.home.direnv = { pkgs, ... }: {
    packages = [ pkgs.nix-direnv ];
    rum.programs.direnv = {
      enable = true;
      integrations.zsh.enable = true;
    };
  };
}
