{inputs, ...}: {
  parts.nixosConfigurations = {
    dorothy = {
      system = "x86_64-linux";
      stateVersion = "23.11";

      modules = [
        inputs.chaotic.nixosModules.default
        ./dorothy/configuration.nix
      ];
    };
  };
}
