{
  self,
  inputs,
  ...
}: let
  defaultModules = [
    inputs.nur.hmModules.nur
    inputs.nix-index-database.hmModules.nix-index
    ../modules/home-manager
  ];

  extraSpecialArgs = {inherit inputs self;};
in {
  flake = {
    homeConfigurations = {
      "chtc@dorothy" = inputs.home.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        inherit extraSpecialArgs;

        modules =
          defaultModules
          ++ [
            inputs.plasma-manager.homeManagerModules.plasma-manager
            ./chtc/home.nix
          ];
      };
    };
  };
}
