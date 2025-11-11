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
          hostname-debian
          iproute2
          iputils
          xz
          libcap
          ncurses
          netcat
          mkpasswd
          procps
          su
          time
          util-linux
          uutils-coreutils-noprefix
          uutils-diffutils
          uutils-findutils
          which
          zstd
          ;

        ssh = config.programs.ssh.package;
      }
    );
    systemPackages = lib.attrValues {
      inherit (pkgs) git moor;

      npins = project.inputs.npins.result { inherit pkgs system; };
    };
  };
}
