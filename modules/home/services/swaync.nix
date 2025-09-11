{ config, lib, ... }:
{
  services.swaync = lib.mkIf config.mama.desktops.niri.enable {
    enable = true;
    settings = {
      control-center-margin-top = 6;
      control-center-margin-bottom = 6;
      control-center-margin-right = 6;
    };
  };
}
