{ lib, config, ... }:
let
  inherit (lib) concatStringsSep mkIf;
  avoid = concatStringsSep "|" [
    "Xwayland"
    "dbus-.*"
    "ghostty"
    "hx"
    "kwin_wayland"
    "plasmashell"
    "sddm"
    "ssh-agent"
    "sshd"
    "systemd"
    "systemd-.*"
    "zsh"
  ];

  prefer = concatStringsSep "|" [
    ".*.exe"
    "Isolated Web Co"
    "Web Content"
    "Web Extensions"
    "chrom(e|ium).*"
    "electron"
    "firefox.*"
    "java.*"
    "librewolf.*"
    "nix"
    "pipewire(.*)"
  ];
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

  services.earlyoom = mkIf (!config.mama.profiles.server.enable) {
    enable = true;
    freeSwapThreshold = 2;
    freeMemThreshold = 2;
    extraArgs = [
      "-g"
      "--avoid"
      "'^(${avoid})$'"
      "--prefer"
      "'^(${prefer})$'"
    ];
  };
}
