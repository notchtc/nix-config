{ config }:
{
  config.systems.nixos = {
    elisabeth = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = [
        "${config.inputs.srvos.result}/nixos/desktop"
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
