{
  config.modules.nixos = {
    cpu-amd = {
      boot = {
        kernelParams = [ "amd_pstate=active" ];
        kernelModules = [ "kvm-amd" ];
      };
    };

    cpu-intel = {
      hardware.cpu.intel.updateMicrocode = true;
      boot.kernelModules = [ "kvm-intel" ];
    };
  };
}
