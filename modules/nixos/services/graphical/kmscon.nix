{ config, lib, ... }:
{
  services.kmscon = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;
    hwRender = true;
    extraConfig = "xkb-layout=${config.mama.system.keyMap}";
  };
}
