{
  config.modules.nixos.packages =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib.attrsets) attrValues optionalAttrs;
      inherit (lib.lists) genList;
      inherit (lib.modules) mkForce;
      inherit (lib.strings) concatStringsSep stringLength;
      inherit (pkgs) writeScriptBin symlinkJoin;

      coreutils-full-name =
        "coreuutils-full"
        + concatStringsSep "" (genList (_: "_") (stringLength pkgs.coreutils-full.version));

      coreutils-name =
        "coreuutils" + concatStringsSep "" (genList (_: "_") (stringLength pkgs.coreutils.version));

      diffutils-name =
        "diffuutils" + concatStringsSep "" (genList (_: "_") (stringLength pkgs.diffutils.version));

      findutils-name =
        "finduutils" + concatStringsSep "" (genList (_: "_") (stringLength pkgs.findutils.version));

      hostname-name =
        "hostname-uutils"
        + concatStringsSep "" (genList (_: "_") ((stringLength pkgs.hostname-debian.version) + 1));

      procps-name = "uprocps" + concatStringsSep "" (genList (_: "_") (stringLength pkgs.procps.version));

      sed-name =
        "uused" + concatStringsSep "" (genList (_: "_") ((stringLength pkgs.gnused.version) + 2));
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
              ncurses
              netcat-openbsd
              util-linux
              xz
              zstd
              ;

            inherit (config.programs.ssh) package;
            inherit (pkgs.stdenv.cc) libc;
          };

        systemPackages =
          attrValues
          <|
            {
              inherit (pkgs)
                uutils-coreutils-noprefix
                uutils-diffutils
                uutils-findutils
                uutils-hostname
                uutils-procps
                uutils-sed
                ;

              inherit (pkgs)
                _7zz
                bottom
                dash
                deadnix
                dust
                eza
                fd
                file
                gitMinimal
                jq
                npins
                ripgrep
                statix
                unrar
                ;

              inherit (pkgs.ghostty) terminfo;

              sh = writeScriptBin "sh" ''
                #!/bin/sh
                exec dash "$@"
              '';
            }
            // optionalAttrs config.xdg.portal.enable {
              inherit (pkgs)
                feather
                ffmpeg
                gimp
                pwvucontrol
                sparrow
                tutanota-desktop
                yt-dlp
                ;

              nvtop = pkgs.nvtopPackages.amd.override {
                intel = true;
                nvidia = true;
              };
            };
      };

      system.replaceDependencies.replacements = [
        {
          oldDependency = pkgs.coreutils-full;
          newDependency = symlinkJoin {
            name = coreutils-full-name;
            paths = [ pkgs.uutils-coreutils-noprefix ];
          };
        }
        {
          oldDependency = pkgs.coreutils;
          newDependency = symlinkJoin {
            name = coreutils-name;
            paths = [ pkgs.uutils-coreutils-noprefix ];
          };
        }
        {
          oldDependency = pkgs.diffutils;
          newDependency = symlinkJoin {
            name = diffutils-name;
            paths = [ pkgs.uutils-diffutils ];
          };
        }
        {
          oldDependency = pkgs.findutils;
          newDependency = symlinkJoin {
            name = findutils-name;
            paths = [ pkgs.uutils-findutils ];
          };
        }
        {
          oldDependency = pkgs.hostname-debian;
          newDependency = symlinkJoin {
            name = hostname-name;
            paths = [ pkgs.uutils-hostname ];
          };
        }
        {
          oldDependency = pkgs.procps;
          newDependency = symlinkJoin {
            name = procps-name;
            paths = [ pkgs.uutils-procps ];
          };
        }
        {
          oldDependency = pkgs.gnused;
          newDependency = symlinkJoin {
            name = sed-name;
            paths = [ pkgs.uutils-sed ];
          };
        }
      ];
    };
}
