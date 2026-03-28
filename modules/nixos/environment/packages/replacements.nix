{ lib, pkgs, ... }:
let
  inherit (lib) concatStringsSep genList stringLength;
in
{
  system.replaceDependencies.replacements =
    let
      coreutils-full-name =
        "coreuutils-full-"
        + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.coreutils-full.version) - 1));

      coreutils-name =
        "coreuutils-" + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.coreutils.version) - 1));

      diffutils-name =
        "diffuutils-" + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.diffutils.version) - 1));

      findutils-name =
        "finduutils-" + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.findutils.version) - 1));

      hostname-name =
        "hostname-uutils-"
        + concatStringsSep "" (genList (_: "v") (stringLength pkgs.hostname-debian.version));

      procps-name = "uuproc-" + concatStringsSep "" (genList (_: "v") (stringLength pkgs.procps.version));

      sed-name = "uutsed-" + concatStringsSep "" (genList (_: "v") (stringLength pkgs.gnused.version));

      less-name =
        "mooor-" + concatStringsSep "" (genList (_: "v") ((stringLength pkgs.less.version) - 1));

      wl-clipboard-name =
        "rs-clipboard-" + concatStringsSep "" (genList (_: "v") (stringLength pkgs.wl-clipboard.version));
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
        oldDependency = pkgs.diffutils;
        newDependency = pkgs.symlinkJoin {
          name = diffutils-name;
          paths = [ pkgs.uutils-diffutils ];
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
        oldDependency = pkgs.hostname-debian;
        newDependency = pkgs.symlinkJoin {
          name = hostname-name;
          paths = [ pkgs.uutils-hostname ];
        };
      }
      {
        oldDependency = pkgs.procps;
        newDependency = pkgs.symlinkJoin {
          name = procps-name;
          paths = [ pkgs.uutils-procps ];
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
        oldDependency = pkgs.less;
        newDependency = pkgs.symlinkJoin {
          name = less-name;
          paths = [ pkgs.moor ];
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
