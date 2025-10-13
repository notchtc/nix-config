{ config }:
{
  config.systems.nixos = {
    dorothy = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = [
        ../modules/nixos
        ./dorothy
      ];

      args = {
        host = "dorothy";
        project = config;
        system = "x86_64-linux";
      };
    };

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
