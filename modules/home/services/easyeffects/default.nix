{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    services.easyeffects = {
      enable = true;
      preset = "LoudnessEqualizer";

      extraPresets = {
        "Sony MDR-ZX310" = builtins.fromJSON (builtins.readFile ./sonymdrzx-310.json);
      };
    };

    xdg.configFile = {
      "easyeffects/output/LoudnessEqualizer.json".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/refs/heads/master/LoudnessEqualizer.json";
        hash = "sha256-lphnEyuRestYTEtspHhkpdG0n2oKzKfrX5L1X7wZB4k=";
      };
    };
  };
}
