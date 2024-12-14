{ lib, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };

  hardware.pulseaudio = {
    enable = lib.mkForce false;
    extraClientConf = "cookie-file = ~/.config/pulse/cookie";
  };
}
