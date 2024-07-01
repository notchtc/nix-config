{ self, inputs, ... }:
let
  defaultModules = [
    inputs.chaotic.nixosModules.default
    inputs.nur.nixosModules.nur
    self.nixosModules.common
  ];

  specialArgs = {
    inherit inputs self;
  };
in
{
  flake.nixosConfigurations = {
    dorothy = inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = defaultModules ++ [
        inputs.disko.nixosModules.disko

        { services.displayManager.autoLogin.user = "chtc"; }

        self.nixosModules.user-chtc
        self.nixosModules.amdgpu
        self.nixosModules.ananicy
        self.nixosModules.graphics
        self.nixosModules.nh
        self.nixosModules.pipewire
        self.nixosModules.plasma
        self.nixosModules.power
        self.nixosModules.steam

        ./dorothy/configuration.nix
      ];
    };
  };
}
