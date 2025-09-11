{ config, lib, ... }:
{
  services.wlsunset = lib.mkIf config.mama.desktops.niri.enable {
    enable = true;
    sunrise = "06:00";
    sunset = "19:30";
    temperature.night = 2500;
  };
}
