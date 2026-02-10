{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mama.programs.bottles.enable = lib.mkEnableOption "Bottles" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.environment.systemPackages = lib.mkIf config.mama.programs.bottles.enable [
    (pkgs.bottles.override { removeWarningPopup = true; })
  ];
}
