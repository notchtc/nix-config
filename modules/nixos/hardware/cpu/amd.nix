{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [ "${inputs.ucodenix.result}/modules/nixos.nix" ];

  config = lib.mkIf (config.mama.hardware.cpu == "amd") {
    hardware.cpu.amd.updateMicrocode = true;
    services.ucodenix.enable = true;

    boot = {
      kernelParams = [ "amd_pstate=active" ];
      kernelModules = [ "kvm-amd" ];
    };
  };
}
