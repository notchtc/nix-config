{
  config.modules.nixos.cpu-amd = { inputs, ... }: {
    imports = [ "${inputs.ucodenix.result}/modules/nixos.nix" ];

    services.ucodenix.enable = true;

    boot = {
      kernelParams = [ "amd_pstate=active" ];
      kernelModules = [ "kvm-amd" ];
    };
  };

  config.modules.nixos.cpu-intel = {
    hardware.cpu.intel.updateMicrocode = true;
    boot.kernelModules = [ "kvm-intel" ];
  };
}
