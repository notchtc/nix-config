{ config }:
{
  config.systems.nixos = {
    "dorothy" = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = [
        config.inputs.disko.result.nixosModules.disko
        "${config.inputs.nixos-hardware.result}/common/cpu/intel/skylake"
        "${config.inputs.nixos-hardware.result}/common/gpu/amd"

        config.modules.nixos.common
        config.modules.nixos.desktop
        config.modules.nixos.gaming
        config.modules.nixos.laptop
        config.modules.nixos.user-chtc

        ./dorothy
      ];

      args = {
        project = config;
        host = "dorothy";
      };

      homes = { inherit (config.homes) "chtc:x86_64-linux"; };
    };
  };
}
