{
  config.modules.nixos.boot = {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;

      limine = {
        enable = true;

        efiSupport = true;
        enableEditor = false;
        maxGenerations = 5;
        secureBoot.enable = true;

        style.wallpapers = [ ];
      };
    };
  };
}
