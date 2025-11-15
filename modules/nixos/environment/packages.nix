{
  config,
  lib,
  pkgs,
  project,
  system,
  ...
}:
{
  environment = {
    defaultPackages = lib.mkForce [ ];
    corePackages = lib.mkForce (
      lib.attrValues {
        inherit (pkgs)
          acl
          attr
          bashInteractive
          bzip2
          cpio
          curl
          gawk
          getent
          getconf
          gnugrep
          gnupatch
          gnused
          gnutar
          gzip
          host
          iproute2
          iputils
          xz
          libcap
          ncurses
          netcat
          mkpasswd
          procps
          util-linux
          uutils-coreutils-noprefix
          uutils-diffutils
          uutils-findutils
          zstd
          ;

        busybox = pkgs.busybox.overrideAttrs (prev: {
          postInstall = prev.postInstall + ''
            rm $out/bin/less
            rm $out/bin/su
          '';
        });
        ssh = config.programs.ssh.package;
      }
    );
    systemPackages = lib.attrValues {
      inherit (pkgs) git moor;
      inherit (pkgs.ghostty) terminfo;

      npins = project.inputs.npins.result { inherit pkgs system; };
    };
  };
}
