{
  config.modules.nixos.mineral =
    {
      config,
      inputs,
      lib,
      ...
    }:
    let
      inherit (lib.attrsets) optionalAttrs;
      inherit (lib.modules) mkIf;
    in
    {
      imports = [ inputs.nix-mineral.result.nixosModules.nix-mineral ];

      nix-mineral = {
        enable = true;

        settings = {
          system.proc-mem-force = "never";

          network = {
            ip-forwarding = true;
            router-advertisements = "off";
          };
        };

        extras = {
          kernel.intelme-kmodules = false;
          network.bluetooth-kmodules = mkIf (!config.hardware.bluetooth.enable) false;
          system.lock-root = true;
        };
      }
      // optionalAttrs config.xdg.portal.enable {
        settings = {
          kernel = {
            cpu-mitigations = "smt-on";
            pti = false;
          };
          system.multilib = true;
        };

        filesystems = {
          normal = {
            "/home".options."noexec" = false;
            "/tmp".options."noexec" = false;
          };
        };
      };
    };
}
