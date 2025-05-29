{ config }:
{
  config.systems.nixos = {
    "dorothy" = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = [
        config.inputs.disko.result.nixosModules.disko
        config.inputs.nixos-hardware.result.nixosModules.common-cpu-intel
        config.inputs.nixos-hardware.result.nixosModules.common-gpu-amd-southern-islands

        ../modules/nixos/gaming
        ../modules/nixos/laptop
        ../modules/nixos/user-chtc
        ./dorothy
      ];

      args = {
        project = config;
        host = "dorothy";
      };
    };
  };
}
