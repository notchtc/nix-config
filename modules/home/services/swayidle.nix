{
  config,
  lib,
  pkgs,
  ...
}:
{

  services.swayidle =
    let
      hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
      loginctl = "${pkgs.systemd}/bin/loginctl";
      niri = "${pkgs.niri}/bin/niri";
    in
    lib.mkIf config.mama.desktops.niri.enable {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "${loginctl} lock-session";
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
          command = "${loginctl} lock-session";
        }
        {
          event = "after-resume";
          command = "${niri} msg action power-on-monitors";
        }
      ];
    };
}
