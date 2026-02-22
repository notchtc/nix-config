{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mama.programs.fluidsynth.enable = lib.mkEnableOption "Fluidsynth" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.environment.systemPackages = lib.mkIf config.mama.programs.fluidsynth.enable [
    pkgs.fluidsynth
  ];
}
