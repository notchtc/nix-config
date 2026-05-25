{ config, lib, ... }:
{
  systemd = lib.mkIf config.mama.profiles.graphical.enable {
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
}
