{ config, lib, ... }:
let
  inherit (lib) mkIf mkForce;
  graphical = config.mama.profiles.graphical.enable;
in
{
  config = mkIf graphical {
    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };

      pulseaudio = {
        enable = mkForce false;
        extraClientConf = ''
          cookie-file = ~/.config/pulse/cookie
        '';
      };
    };
  };
}
