{ config }:
let
  inherit (builtins) attrValues;
  inherit (config.modules) home nixos;
in
{
  config.systems.nixos = {
    elisabeth = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules =
        attrValues (
          removeAttrs nixos [
            "cpu-intel"
            "gpu-intel"
            "virtualisation"
          ]
        )
        ++ [
          "${config.inputs.srvos.result}/nixos/desktop"

          ./_configuration.nix

          { hjem.extraModules = attrValues home; }
        ];

      args = { inherit (config) inputs modules; };
    };
  };
}
