{
  config.modules.nixos.systemd =
    { config, lib, ... }:
    let
      inherit (lib.modules) mkIf;
    in
    {
      systemd = mkIf config.xdg.portal.enable {
        settings.Manager = {
          DefaultTimeoutStartSec = "15s";
          DefaultTimeoutStopSec = "15s";
          DefaultTimeoutAbortSec = "15s";
          DefaultDeviceTimeoutSec = "15s";
        };

        user.settings.Manager = {
          DefaultTimeoutStartSec = "15s";
          DefaultTimeoutStopSec = "15s";
          DefaultTimeoutAbortSec = "15s";
          DefaultDeviceTimeoutSec = "15s";
        };
      };
    };
}
