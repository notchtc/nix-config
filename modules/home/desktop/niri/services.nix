{ pkgs, ... }:
let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  niri = "${pkgs.niri-unstable}/bin/niri";
  pidof = "${pkgs.procps}/bin/pidof";
  systemctl = "${pkgs.systemd}/bin/systemctl";
in
{
  services = {
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 180;
          command = "${brightnessctl} -s set 10";
        }
        {
          timeout = 300;
          command = "${loginctl} lock-session";
        }
        {
          timeout = 360;
          command = "${niri} msg action power-off-monitors";
        }
        {
          timeout = 600;
          command = "${systemctl} suspend";
        }
      ];
      events = [
        {
          event = "lock";
          command = "${pidof} hyprlock || ${hyprlock}";
        }
        {
          event = "before-sleep";
          command = "${loginctl} lock-session";
        }
        {
          event = "after-resume";
          command = "${niri} msg action power-on-monitors && ${brightnessctl} -r";
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
