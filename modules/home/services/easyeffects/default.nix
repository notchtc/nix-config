{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  loadPreset = path: builtins.fromJSON <| builtins.readFile path;
in
{
  services.easyeffects = lib.mkIf osConfig.mama.profiles.graphical.enable {
    enable = true;
    preset = "LoudnessEqualizer";

    extraPresets = {
      "Sony MDR-ZX310" = loadPreset ./sonymdr-zx310.json;
      "LoudnessEqualizer" =
        loadPreset
        <| pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/refs/heads/master/LoudnessEqualizer.json";
          hash = "sha256-1vVMz+X+Zxldo7ull6FL3IGdvzuDO3nNosE3nPclvKw=";
        };
    };
  };
}
