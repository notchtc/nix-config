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
        preset = "maximum";

        settings.network = {
          ip-forwarding = true;
          router-advertisements = "off";
        };

        extras = {
          kernel.warn-panic = false;
          misc.ssh-hardening = true;
          network.tcp-window-scaling = true;
          system = {
            minimize-swapping = false;
            secure-chrony = false;
          };
        };

        kernel-modules.disable = {
          bluetooth-related = mkIf config.hardware.bluetooth.enable false;
          udf = false;
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
