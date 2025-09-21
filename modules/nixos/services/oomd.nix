{ lib, config, ... }:
{
  systemd = {
    oomd = {
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;
      extraConfig.DefaultMemoryPressureDurationSec = "20s";
    };
    services.nix-daemon.serviceConfig.OOMScoreAdjust = 350;
  };

  services.earlyoom = lib.mkIf (!config.mama.profiles.server.enable) {
    enable = true;
    freeSwapThreshold = 2;
    freeMemThreshold = 2;
    extraArgs = [
      "-g"
      "--avoid"
      "'^(niri|foot|hx|cryptsetup|dbus-.*|Xwayland|systemd|systemd-.*|ssh-agent|greetd)$'"
      "--prefer"
      "'^(Web Content|Isolated Web Co|firefox.*|electron|nix|.*.exe|pipewire(.*))$'"
    ];
  };
}
