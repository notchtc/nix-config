{inputs, ...}: {
  parts.homeConfigurations = {
    "chtc@dorothy" = {
      system = "x86_64-linux";
      stateVersion = "23.11";

      modules = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
        ./chtc/home.nix
      ];
    };
  };
}
