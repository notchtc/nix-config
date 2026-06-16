{
  config.modules.nixos.kmscon = { config, ... }: {
    services.kmscon = {
      enable = true;

      config = {
        font-name = "Atkinson Hyperlegible Mono";
        hwaccel = true;
        xkb-layout = config.console.keyMap;
      };
    };
  };
}
