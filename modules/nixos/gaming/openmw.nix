{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.programs.gaming.openmw.enable {
    environment.systemPackages = lib.attrValues {
      inherit (inputs.openmw-nix.result.packages.${pkgs.system})
        #        delta-plugin
        momw-configurator
        openmw-validator
        s3lightfixes
        umo
        ;

      inherit (pkgs) openmw;
    };
  };
}
