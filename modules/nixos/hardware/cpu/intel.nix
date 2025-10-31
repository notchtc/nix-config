{ config, lib, ... }:
let
  inherit (lib) mkIf;
  inherit (config.mama.hardware) cpu;
in
{
  config = mkIf (cpu == "intel") {
    hardware.cpu.intel.updateMicrocode = true;

    boot = {
      kernelModules = [ "kvm-intel" ];
    };
  };
}
