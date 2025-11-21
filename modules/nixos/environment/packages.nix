{
  config,
  lib,
  pkgs,
  project,
  system,
  ...
}:
let
  inherit (lib) attrValues mkForce;
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
          curl
          gawk
          getent
          getconf
          host
          iproute2
          iputils
          libcap
          mkpasswd
          moor
          ncurses
          netcat
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
      };

    systemPackages = attrValues {
      inherit (pkgs) deadnix git statix;
      inherit (pkgs.ghostty) terminfo;

      npins = project.inputs.npins.result { inherit pkgs system; };
    };
  };
}
