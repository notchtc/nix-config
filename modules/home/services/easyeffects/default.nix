{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
  loadPreset = path: builtins.fromJSON (builtins.readFile path);
in
{
  config.services.easyeffects = mkIf graphical {
    enable = true;
    preset = "LoudnessEqualizer";

    extraPresets = {
      "Sony MDR-ZX310" = loadPreset ./sonymdr-zx310.json;
      "LoudnessEqualizer" = loadPreset (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/refs/heads/master/LoudnessEqualizer.json";
          hash = "sha256-5+jYLBzexHWS7c9vghxtb/fZi6bwozroXdw2D6M4+LU=";
        }
      );
    };
  };
}
