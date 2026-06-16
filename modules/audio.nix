{
  config.modules.nixos.audio =
    { lib, ... }:
    let
      inherit (lib.modules) mkForce;
    in
    {
      services = {
        pipewire = {
          alsa.support32Bit = true;
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
