{ lib, config, ... }:
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

  services.earlyoom = lib.mkIf (!config.mama.profiles.server.enable) {
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
