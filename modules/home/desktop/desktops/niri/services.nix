{ pkgs, ... }:
let
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
  niri = "${pkgs.niri-unstable}/bin/niri";
in
{
  services = {
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "loginctl lock-session";
        }
        {
          timeout = 450;
          command = "${niri} msg action power-off-monitors";
        }
      ];
      events = [
        {
          event = "lock";
          command = "${hyprlock}";
        }
        {
          event = "before-sleep";
          command = "loginctl lock-session";
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

    wlsunset = {
      enable = true;
      sunrise = "06:00";
      sunset = "19:30";
      temperature.night = 2500;
    };
  };
}
