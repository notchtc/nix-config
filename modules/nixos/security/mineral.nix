{
  config,
  lib,
  project,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.mama.profiles;
in
{
  imports = [ "${project.inputs.nix-mineral.result}/nix-mineral.nix" ];

  nix-mineral = {
    enable = true;
    overrides = {
      compatibility.allow-ip-forward = true;
      desktop = mkIf cfg.graphical.enable {
        allow-multilib = true;
        hideproc-off = true;
        home-exec = true;
        skip-restrict-home-permission = true;
        tmp-exec = true;
      };
      performance.allow-smt = true;
      security = {
        disable-bluetooth-kmodules = mkIf cfg.server.enable true;
        disable-intelme-kmodules = true;
        lock-root = true;
      };
    };
  };
}
