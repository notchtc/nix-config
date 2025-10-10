{
  config,
  lib,
  pkgs,
  project,
  system,
  ...
}:
{
  environment.systemPackages = lib.mkIf config.mama.programs.gaming.openmw.enable lib.attrValues {
    inherit (project.inputs.openmw-nix.result.packages.${system})
      delta-plugin
      momw-configurator
      openmw-validator
      s3lightfixes
      umo
      ;

    inherit (pkgs) openmw;
  };
}
