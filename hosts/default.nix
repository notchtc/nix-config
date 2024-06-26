{ self, inputs, ... }:
let
  defaultModules = [
    inputs.nur.nixosModules.nur
    inputs.chaotic.nixosModules.default
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
        self.nixosModules.plasma
        self.nixosModules.amdgpu
        self.nixosModules.graphics
        self.nixosModules.ananicy
        self.nixosModules.steam
        self.nixosModules.pipewire
        self.nixosModules.power

        ./dorothy/configuration.nix
      ];
    };
  };
}
