{ config, lib, ... }:
{
  config = lib.mkIf (config.mama.hardware.cpu == "intel") {
    hardware.cpu.intel.updateMicrocode = true;

    boot = {
      kernelModules = [ "kvm-intel" ];
    };
  };
}
