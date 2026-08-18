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
          kernel.sysrq = "sak";
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
          misc.ssh-hardening = true;
          system.lock-root = true;
        };

        kernel-modules.disable.bluetooth-related = mkIf config.hardware.bluetooth.enable false;
      }
      // optionalAttrs config.xdg.portal.enable {
        settings = {
          kernel = {
            cpu-mitigations = "smt-on";
            pti = false;
          };
          system.multilib = true;
        };

        kernel-modules.disable = {
          cdrom-related = false;
          udf = false;
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
