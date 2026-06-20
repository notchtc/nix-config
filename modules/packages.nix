{
  config.modules.nixos.packages =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib.modules) mkForce;
      inherit (lib.attrsets) attrValues optionalAttrs;
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
              ncurses
              netcat-openbsd
              time
              util-linux
              which
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
                _7zz-rar
                bat
                bottom
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
                ;
            }
            // optionalAttrs config.xdg.portal.enable {
              inherit (pkgs)
                ffmpeg
                gimp
                keepassxc
                pwvucontrol
                renoise
                tutanota-desktop
                yt-dlp
                ;

              nvtop = pkgs.nvtopPackages.amd.override {
                intel = true;
                nvidia = true;
              };
            };
      };
    };
}
