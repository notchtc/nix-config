{
  config.modules.nixos.memory =
    { config, lib, ... }:
    let
      inherit (lib.modules) mkIf;
      inherit (lib.strings) concatStringsSep;
    in
    {
      zramSwap = {
        enable = true;
        memoryPercent = 150;
      };

      boot.kernel.sysctl = {
        "vm.page-cluster" = 0;
        "vm.swappiness" = 180;
        "vm.watermark_boost_factor" = 0;
        "vm.watermark_scale_factor" = 125;
      };

      systemd.oomd = {
        enableRootSlice = true;
        enableSystemSlice = true;
        enableUserSlices = true;
        settings.OOM.DefaultMemoryPressureDurationSec = "20s";
      };

      services.earlyoom =
        let
          avoid = concatStringsSep "|" [
            "dbus-.*"
            "ghostty"
            "greetd"
            "hx"
            "niri"
            "noctalia"
            "ssh-agent"
            "sshd"
            "systemd-.*"
            "systemd"
            "Xwayland"
            "xwayland-satellite"
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
        mkIf config.xdg.portal.enable {
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
    };
}
