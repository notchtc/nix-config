{ lib, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.pulseaudio.enable = lib.mkForce false;
  environment.etc."pulse/client.conf".text = "cookie-file = ~/.config/pulse/cookie";
}
