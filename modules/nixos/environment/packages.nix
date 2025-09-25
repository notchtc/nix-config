{
  lib,
  pkgs,
  project,
  system,
  ...
}:
{
  environment = {
    defaultPackages = lib.mkForce [ ];
    systemPackages = lib.attrValues {
      inherit (pkgs)
        busybox
        gitMinimal
        ragenix
        uutils-coreutils-noprefix
        ;

      npins = project.inputs.npins.result { inherit pkgs system; };
    };
  };
}
