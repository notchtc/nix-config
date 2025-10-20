{
  config,
  lib,
  pkgs,
  ...
}:
let
  loadPreset = path: builtins.fromJSON (builtins.readFile path);
in
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    services.easyeffects = {
      enable = true;
      preset = "LoudnessEqualizer";

      extraPresets = {
        "Sony MDR-ZX310" = loadPreset ./sonymdrzx-310.json;
        "LoudnessEqualizer" = loadPreset (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/refs/heads/master/LoudnessEqualizer.json";
            hash = "sha256-ubu4uCN8NEv4AtVbdIxFjJn9wC8o2Hw3WwSidiXuEoY=";
          }
        );
      };
    };
  };
}
