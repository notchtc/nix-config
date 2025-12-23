{ config }:
{
  config.systems.nixos = {
    elisabeth = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = [
        config.inputs.autoaspm.result.nixosModules.default
        ../modules/nixos
        ./elisabeth
      ];

      args = {
        inherit (config) inputs packages;
        host = "elisabeth";
        system = "x86_64-linux";
      };
    };
  };
}
