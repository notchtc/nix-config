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
      inherit (pkgs) busybox gitMinimal ragenix;

      npins = project.inputs.npins.result { inherit pkgs system; };
      uutils = lib.hiPrio pkgs.uutils-coreutils-noprefix;
    };
  };
}
