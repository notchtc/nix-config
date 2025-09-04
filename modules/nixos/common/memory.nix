{
  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };

  systemd.oomd.extraConfig.DefaultMemoryPressureDurationSec = "20s";
  services.earlyoom = {
    enable = true;
    freeSwapThreshold = 2;
    freeMemThreshold = 2;
    extraArgs = [
      "-g"
      "--avoid"
      "'^(niri|foot|Xwayland|greetd|cryptsetup|hx|ssh-agent|systemd|sshd)$'"
      "--prefer"
      "'^(Web Content|Isolated Web Co|firefox.*|electron|nix|.*.exe|pipewire)$'"
    ];
  };

  boot.kernel.sysctl = {
    "vm.dirty_bytes" = 268435456;
    "vm.dirty_background_bytes" = 134217728;
    "vm.max_map_count" = 2147483642;
    "vm.page-cluster" = 0;
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
  };
}
