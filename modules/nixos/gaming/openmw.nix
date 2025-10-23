{
  config,
  lib,
  pkgs,
  project,
  system,
  ...
}:
{
  options.mama.profiles.gaming.openmw.enable = lib.mkEnableOption "OpenMW" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.environment.systemPackages = lib.mkIf config.mama.profiles.gaming.openmw.enable (
    lib.attrValues {
      inherit (project.inputs.openmw-nix.result.packages.${system})
        delta-plugin
        momw-configurator
        openmw-validator
        s3lightfixes
        umo
        ;

      inherit (pkgs) openmw;
    }
  );
}
