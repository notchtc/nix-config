{ config }:
{
  config.systems.nixos = {
    elisabeth = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = [
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
