{
  config,
  lib,
  pkgs,
  project,
  system,
  ...
}:
let
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.openmw.enable = lib.mkEnableOption "OpenMW" // {
    default = gaming.enable;
  };

  config.environment.systemPackages =
    lib.mkIf gaming.openmw.enable
    <| lib.attrValues {
      inherit (project.inputs.openmw-nix.result.packages.${system})
        #      delta-plugin
        momw-configurator
        openmw-validator
        s3lightfixes
        umo
        ;

      inherit (pkgs) openmw;
    };
}
