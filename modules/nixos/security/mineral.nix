{
  config,
  lib,
  project,
  ...
}:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
  server = config.mama.profiles.server.enable;
in
{
  imports = [ "${project.inputs.nix-mineral.result}/nix-mineral.nix" ];

  nix-mineral = {
    enable = true;
    overrides = {
      compatibility.allow-ip-forward = true;
      desktop = mkIf graphical {
        allow-multilib = true;
        hideproc-off = true;
        home-exec = true;
        skip-restrict-home-permission = true;
        tmp-exec = true;
      };
      performance.allow-smt = true;
      security = {
        disable-bluetooth-kmodules = mkIf server true;
        disable-intelme-kmodules = true;
        lock-root = true;
      };
    };
  };
}
