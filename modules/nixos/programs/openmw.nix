{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.mama.programs.openmw.enable = lib.mkEnableOption "OpenMW" // {
    default = config.mama.profiles.gaming.enable;
  };

  config.environment.systemPackages =
    lib.mkIf config.mama.programs.openmw.enable
    <| lib.attrValues {
      inherit (inputs.openmw-nix.result.packages.${pkgs.stdenv.hostPlatform.system})
        #      delta-plugin
        momw-configurator
        openmw-validator
        s3lightfixes
        umo
        ;

      inherit (pkgs) openmw;
    };
}
