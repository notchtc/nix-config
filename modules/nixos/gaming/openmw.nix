{
  config,
  lib,
  pkgs,
  project,
  system,
  ...
}:
let
  inherit (lib) attrValues mkEnableOption mkIf;
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.openmw.enable = mkEnableOption "OpenMW" // {
    default = gaming.enable;
  };

  config.environment.systemPackages = mkIf gaming.openmw.enable (attrValues {
    inherit (project.inputs.openmw-nix.result.packages.${system})
      #      delta-plugin
      momw-configurator
      openmw-validator
      s3lightfixes
      umo
      ;

    inherit (pkgs) openmw;
  });
}
