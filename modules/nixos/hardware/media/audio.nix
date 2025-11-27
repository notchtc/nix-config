{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
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
        enable = lib.mkForce false;
        extraClientConf = ''
          cookie-file = ~/.config/pulse/cookie
        '';
      };
    };
  };
}
