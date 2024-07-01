{ self, inputs, ... }:
let
  defaultModules = [
    inputs.nur.hmModules.nur
    inputs.chaotic.homeManagerModules.default
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

          self.homeModules.foot
          self.homeModules.mpv
          self.homeModules.plasma
          self.homeModules.schizofox

          ./chtc/home.nix
        ];
      };
    };
  };
}
