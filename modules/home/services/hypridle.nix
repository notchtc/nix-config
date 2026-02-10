{ lib, profiles, ... }:
{
  services.hypridle = lib.mkIf profiles.graphical.enable {
    enable = true;
    settings = {
      general = {
        lock_cmd = "noctalia-shell ipc call lockScreen lock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "niri msg action power-on-monitors";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "noctalia-shell ipc call lockScreen lock";
        }
        {
          timeout = 400;
          on-timeout = "noctalia-shell ipc call sessionMenu lockAndSuspend";
        }
      ];
    };
  };
}
