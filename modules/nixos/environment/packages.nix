{
  config,
  inputs,
  lib,
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
    optionalAttrs
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
          bashInteractive
          bzip2
          cpio
          curl
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
          procps
          time
          util-linux
          which
          xz
          zstd
          ;

        inherit (pkgs.stdenv.cc) libc;

        ssh = config.programs.ssh.package;
      };

    systemPackages =
      attrValues
      <|
        {
          inherit (pkgs)
            aria2
            deadnix
            ffmpeg
            file
            git
            moor
            statix
            uutils-coreutils-noprefix
            uutils-diffutils
            uutils-findutils
            uutils-sed
            ;

          inherit (pkgs.ghostty) terminfo;

          npins = inputs.npins.result { inherit pkgs system; };
        }
        // optionalAttrs config.mama.profiles.graphical.enable {
          inherit (pkgs)
            gimp
            keepassxc
            nicotine-plus
            picard
            pwvucontrol
            qbittorrent
            qpwgraph
            strawberry
            tutanota-desktop
            ;

          inherit (pkgs.kdePackages)
            arianna
            ark
            gwenview
            okular
            ;

          telegram = pkgs.telegram-desktop.override { withWebkit = false; };
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
