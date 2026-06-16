{
  config.modules.nixos.mineral =
    {
      config,
      inputs,
      lib,
      ...
    }:
    let
      inherit (lib.attrsets) genAttrs optionalAttrs;
      inherit (lib.modules) mkIf;
    in
    {
      imports = [ inputs.nix-mineral.result.nixosModules.nix-mineral ];

      boot.kexec.enable = false;

      nix-mineral = {
        enable = true;

        settings = {
          kernel.cpu-mitigations = "smt-on";
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

        filesystems.normal = genAttrs [ "/etc" "/root" "/srv" "/tmp" "/var" "/var/tmp" ] (_: {
          options.fsType = "none";
        });
      }
      // optionalAttrs config.xdg.portal.enable {
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
    };
}
