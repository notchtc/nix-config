{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    services = {
      pipewire = {
        alsa.support32Bit = true;
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
