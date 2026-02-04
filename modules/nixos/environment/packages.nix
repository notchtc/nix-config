{
  config,
  inputs,
  lib,
  packages,
  pkgs,
  system,
  ...
}:
let
  inherit (lib)
    attrValues
    concatStringsSep
    genList
    mkForce
    stringLength
    ;
in
{
  environment = {
    defaultPackages = mkForce [ ];
    corePackages =
      mkForce
      <| attrValues {
        inherit (pkgs)
          acl
          attr
          bzip2
          cpio
          curl
          file
          gawk
          getconf
          getent
          gnugrep
          gnupatch
          gnutar
          gzip
          host
          iproute2
          iputils
          libcap
          lsof
          mkpasswd
          moor
          ncurses
          netcat
          time
          util-linux
          which
          xz
          zstd
          ;

        inherit (pkgs.stdenv.cc) libc;

        dash = packages.dash-sh.result.${system};
        ssh = config.programs.ssh.package;
      };

    systemPackages = attrValues {
      inherit (pkgs)
        deadnix
        ffmpeg
        git
        moor
        statix
        uutils-coreutils-noprefix
        uutils-diffutils
        uutils-findutils
        uutils-procps
        uutils-sed
        ;

      inherit (pkgs.ghostty) terminfo;

      npins = inputs.npins.result { inherit pkgs system; };
    };
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
    ];
}
