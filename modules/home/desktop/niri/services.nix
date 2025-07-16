{ config, pkgs, ... }:
let
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
  niri = "${pkgs.niri-unstable}/bin/niri";
  systemctl = config.systemd.user.systemctlPath;
in
{
  services = {
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "${niri} msg action power-off-monitors";
        }
        {
          timeout = 600;
          command = "${systemctl} suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${hyprlock}";
        }
        {
          event = "after-resume";
          command = "${niri} msg action power-on-monitors";
        }
      ];
    };

    swaync = {
      enable = true;
      settings = {
        control-center-margin-top = 6;
        control-center-margin-bottom = 6;
        control-center-margin-right = 6;
      };
    };

    swayosd.enable = true;

    wlsunset = {
      enable = true;
      sunrise = "06:00";
      sunset = "19:30";
      temperature.night = 2500;
    };
  };
}
