{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
  loadPreset = path: builtins.fromJSON <| builtins.readFile path;
in
{
  config = mkIf graphical {
    services.easyeffects = {
      enable = true;
      preset = "LoudnessEqualizer";

      #    extraPresets = {
      #      "Sony MDR-ZX310" = loadPreset ./sonymdr-zx310.json;
      #      "LoudnessEqualizer" =
      #        loadPreset
      #        <| pkgs.fetchurl {
      #          url = "https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/refs/heads/master/LoudnessEqualizer.json";
      #          hash = "sha256-1vVMz+X+Zxldo7ull6FL3IGdvzuDO3nNosE3nPclvKw=";
      #        };
    };

    xdg.dataFile = {
      "easyeffects/output/Sony MDR-ZX310.json".source = ./sonymdr-zx310.json;
      "easyeffects/output/LoudnessEqualizer.json".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/refs/heads/master/LoudnessEqualizer.json";
        hash = "sha256-1vVMz+X+Zxldo7ull6FL3IGdvzuDO3nNosE3nPclvKw=";
      };
    };
  };
}
