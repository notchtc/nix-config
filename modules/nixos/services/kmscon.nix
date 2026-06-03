{ config, lib, ... }:
{
  services.kmscon = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;

    config = {
      font-name = "Atkinson Hyperlegible Mono";
      hwaccel = true;
      xkb-layout = config.mama.system.keyMap;
    };
  };
}
