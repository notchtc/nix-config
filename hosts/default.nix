{
  self,
  inputs,
  ...
}: let
  defaultModules = [
    inputs.nur.nixosModules.nur
    self.nixosModules.common
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

          {services.xserver.displayManager.autoLogin.user = "chtc";}

          self.nixosModules.user-chtc
          self.nixosModules.plasma6
          self.nixosModules.opengl
          self.nixosModules.gamemode
          self.nixosModules.steam
          self.nixosModules.pipewire
          self.nixosModules.power

          ./dorothy/configuration.nix
        ];
    };
  };
}
