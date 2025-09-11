{ lib, pkgs, ... }:
{
  environment = {
    defaultPackages = lib.mkForce [ ];
    systemPackages = lib.attrValues {
      inherit (pkgs)
        busybox
        gitMinimal
        npins
        ragenix
        ;

      uutils = lib.hiPrio pkgs.uutils-coreutils-noprefix;
    };
  };
}
