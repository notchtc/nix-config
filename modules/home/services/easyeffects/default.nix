{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
in
{
  config.services.easyeffects = mkIf graphical {
    enable = true;
    preset = "LoudnessEqualizer";

    xdg.configFile = {
      "easyeffects/output/SonyMDR-ZX310.json".source = ./sonymdr-zx310.json;
      "easyeffects/output/LoudnessEqualizer.json".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/refs/heads/master/LoudnessEqualizer.json";
        hash = "sha256-5+jYLBzexHWS7c9vghxtb/fZi6bwozroXdw2D6M4+LU=";
      };
    };
  };
}
