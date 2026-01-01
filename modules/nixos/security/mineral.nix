{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkIf optionalAttrs;
  inherit (config.mama) profiles;
in
{
  imports = [ inputs.nix-mineral.result.nixosModules.nix-mineral ];

  nix-mineral = {
    enable = true;

    settings = {
      kernel.cpu-mitigations = "smt-on";

      network = {
        ip-forwarding = true;
        router-advertisements = "off";
      };

      system = {
        proc-mem-force = "never";
        yama = "restricted";
      };
    };

    extras = {
      kernel.intelme-kmodules = false;
      network.bluetooth-kmodules = mkIf profiles.server.enable false;
      system.lock-root = true;
    };
  }
  // optionalAttrs profiles.graphical.enable {
    settings = {
      kernel.pti = false;
      system.multilib = true;
    };

    filesystems = {
      normal = {
        "/home".options."noexec" = false;
        "/tmp".options."noexec" = false;
      };
    };
  };
}
