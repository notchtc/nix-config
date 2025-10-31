{ config, lib, ... }:
let
  inherit (lib) mkIf;
  inherit (config.mama.hardware) cpu;
in
{
  config = mkIf (cpu == "amd") {
    hardware.cpu.amd.updateMicrocode = true;

    boot = {
      kernelParams = [ "amd_pstate=active" ];
      kernelModules = [
        "kvm-amd"
        "amd-pstate"
      ];
    };
  };
}
