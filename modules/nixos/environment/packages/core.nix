{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.corePackages =
    lib.mkForce
    <| lib.attrValues {
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
}
