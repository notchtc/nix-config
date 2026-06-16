{
  config.modules.nixos.ld = {
    environment.stub-ld.enable = false;
    programs.nix-ld.enable = true;
  };
}
