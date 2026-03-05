{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.kmscon = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;
    hwRender = true;
    extraConfig = "xkb-layout=${config.mama.system.keyMap}";

    fonts = [
      {
        name = "Atkinson Hyperlegible Mono";
        package = pkgs.atkinson-hyperlegible-mono;
      }
    ];
  };
}
