{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    services = {
      dbus.implementation = "broker";
      kmscon = {
        enable = true;
        hwRender = true;
        extraConfig = "xkb-layout=${config.mama.system.keyMap}";
      };
    };

    systemd = {
      settings.Manager = {
        DefaultTimeoutStartSec = "15s";
        DefaultTimeoutStopSec = "15s";
        DefaultTimeoutAbortSec = "15s";
        DefaultDeviceTimeoutSec = "15s";
      };

      user.extraConfig = ''
        DefaultTimeoutStartSec=15s
        DefaultTimeoutStopSec=15s
        DefaultTimeoutAbortSec=15s
        DefaultDeviceTimeoutSec=15s
      '';
    };
  };
}
