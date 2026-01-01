{ config, lib, ... }:
{
  config = lib.mkIf (config.mama.hardware.cpu == "amd") {
    hardware.cpu.amd.updateMicrocode = true;

    boot = {
      kernelParams = [ "amd_pstate=active" ];
      kernelModules = [ "kvm-amd" ];
    };
  };
}
