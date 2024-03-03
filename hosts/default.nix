{
  self,
  inputs,
  ...
}: let
  defaultModules = [
    inputs.nur.nixosModules.nur
    ../modules/nixos
  ];

  specialArgs = {inherit inputs self;};
in {
  flake.nixosConfigurations = {
    dorothy = inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules =
        defaultModules
        ++ [
          inputs.chaotic.nixosModules.default
          inputs.disko.nixosModules.disko
          ./dorothy/configuration.nix
        ];
    };
  };
}
