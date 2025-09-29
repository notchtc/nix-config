{ config }:
{
  config.systems.nixos = {
    dorothy = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = [
        "${config.inputs.nixos-hardware.result}/common/cpu/intel/skylake"
        "${config.inputs.nixos-hardware.result}/common/gpu/amd"
        "${config.inputs.nixos-hardware.result}/common/pc/laptop"

        ../modules/nixos
        ./dorothy
      ];

      args = {
        project = config;
        system = "x86_64-linux";
        hostname = "dorothy";
      };
    };

    elisabeth = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = [
        "${config.inputs.nixos-hardware.result}/common/cpu/amd"
        "${config.inputs.nixos-hardware.result}/common/cpu/amd/pstate.nix"
        "${config.inputs.nixos-hardware.result}/common/gpu/amd"
        "${config.inputs.nixos-hardware.result}/common/gpu/nvidia/prime.nix"
        "${config.inputs.nixos-hardware.result}/common/pc/laptop"

        ../modules/nixos
        ./elisabeth
      ];

      args = {
        project = config;
        system = "x86_64-linux";
        hostname = "elisabeth";
      };
    };
  };
}
