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
        host = "elisabeth";
        project = config;
        system = "x86_64-linux";
      };
    };
  };
}
