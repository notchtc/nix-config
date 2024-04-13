{ self, inputs, ... }:
let
  defaultModules = [
    inputs.nur.hmModules.nur
    self.homeModules.common
  ];

  extraSpecialArgs = {
    inherit inputs self;
  };
in
{
  flake = {
    homeConfigurations = {
      "chtc@dorothy" = inputs.home.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        inherit extraSpecialArgs;

        modules = defaultModules ++ [
          inputs.plasma-manager.homeManagerModules.plasma-manager

          self.homeModules.plasma
          self.homeModules.foot
          self.homeModules.mpv
          self.homeModules.firefox

          ./chtc/home.nix
        ];
      };
    };
  };
}
