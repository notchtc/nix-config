{ lib, config, ... }:
let
  inherit (lib) mkIf;
  server = config.mama.profiles.server.enable;
in
{
  systemd = {
    oomd = {
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;
      settings.OOM.DefaultMemoryPressureDurationSec = "20s";
    };
    services.nix-daemon.serviceConfig.OOMScoreAdjust = 350;
  };

  services.earlyoom = mkIf (!server) {
    enable = true;
    freeSwapThreshold = 2;
    freeMemThreshold = 2;
    extraArgs = [
      "-g"
      "--avoid"
      "'^(ghostty|hx|dbus-.*|Xwayland|systemd|systemd-.*|ssh-agent|sshd|zsh)$'"
      "--prefer"
      "'^(Web Content|Isolated Web Co|firefox.*|electron|nix|.*.exe|pipewire(.*))$|chrom(e|ium).*'"
    ];
  };
}
