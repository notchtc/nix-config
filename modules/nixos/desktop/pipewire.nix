{ lib, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pulseaudio = {
    enable = lib.mkForce false;
    extraClientConf = ''
      cookie-file = ~/.config/pulse/cookie
    '';
  };
}
