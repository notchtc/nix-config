{
  config.modules.nixos.plymouth = { pkgs, ... }: {
    boot.plymouth = {
      enable = true;
      font = "${pkgs.atkinson-hyperlegible-next}/share/fonts/opentype/AtkinsonHyperlegibleNext-Regular.otf";
    };
  };
}
