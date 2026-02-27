{ lib, pkgs, ... }:
let
  inherit (lib)
    attrValues
    concatStringsSep
    genList
    stringLength
    ;
in
{
  environment.systemPackages = attrValues {
    inherit (pkgs)
      uutils-coreutils-noprefix
      uutils-diffutils
      uutils-findutils
      uutils-sed
      ;
  };

  system.replaceDependencies.replacements =
    let
      coreutils-full-name =
        "coreuutils-full-"
        + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.coreutils-full.version) - 1));

      coreutils-name =
        "coreuutils-" + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.coreutils.version) - 1));

      findutils-name =
        "finduutils-" + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.findutils.version) - 1));

      diffutils-name =
        "diffuutils-" + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.diffutils.version) - 1));
      sed-name = "uutsed-" + concatStringsSep "" (genList (_: "v") (stringLength pkgs.gnused.version));
      wl-clipboard-name =
        "uu-clipboard-" + concatStringsSep "" (genList (_: "v") (stringLength pkgs.wl-clipboard.version));
    in
    [
      {
        oldDependency = pkgs.coreutils-full;
        newDependency = pkgs.symlinkJoin {
          name = coreutils-full-name;
          paths = [ pkgs.uutils-coreutils-noprefix ];
        };
      }
      {
        oldDependency = pkgs.coreutils;
        newDependency = pkgs.symlinkJoin {
          name = coreutils-name;
          paths = [ pkgs.uutils-coreutils-noprefix ];
        };
      }
      {
        oldDependency = pkgs.findutils;
        newDependency = pkgs.symlinkJoin {
          name = findutils-name;
          paths = [ pkgs.uutils-findutils ];
        };
      }
      {
        oldDependency = pkgs.diffutils;
        newDependency = pkgs.symlinkJoin {
          name = diffutils-name;
          paths = [ pkgs.uutils-diffutils ];
        };
      }
      {
        oldDependency = pkgs.gnused;
        newDependency = pkgs.symlinkJoin {
          name = sed-name;
          paths = [ pkgs.uutils-sed ];
        };
      }
      {
        oldDependency = pkgs.wl-clipboard;
        newDependency = pkgs.symlinkJoin {
          name = wl-clipboard-name;
          paths = [ pkgs.wl-clipboard-rs ];
        };
      }
    ];
}
