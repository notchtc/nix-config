{
  config,
  lib,
  project,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (config.mama) profiles;
in
{
  imports = [ "${project.inputs.nix-mineral.result}/nix-mineral.nix" ];

  nix-mineral = {
    enable = true;
    overrides = {
      compatibility.allow-ip-forward = true;
      desktop = mkIf profiles.graphical.enable {
        allow-multilib = true;
        hideproc-off = true;
        home-exec = true;
        skip-restrict-home-permission = true;
        tmp-exec = true;
      };
      performance.allow-smt = true;
      security = {
        disable-bluetooth-kmodules = mkIf profiles.server.enable true;
        disable-intelme-kmodules = true;
        lock-root = true;
      };
    };
  };
}
