let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create (
  { config }:
  {
    includes = [ "${pins.nilla-utils}/modules" ];

    config = {
      inputs = {
        nixpkgs.settings.configuration.allowUnfree = true;

        nixpkgs-flake = {
          inherit (config.inputs.nixpkgs) src;
          loader = "flake";
        };

        agenix.loader = "raw";
        impermanence.loader = "raw";
        nixos-hardware.loader = "raw";

        disko.settings.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
        home-manager.settings.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
        nix-index-database.settings.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
        openmw-nix.settings.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
        schizofox.settings.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
        stylix.settings.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
      };

      generators = {
        inputs.pins = pins;
        project.folder = ./.;
        nixos = {
          args.homeModules = config.modules.home;
          modules = [
            config.inputs.disko.result.nixosModules.disko
            config.modules.nixos.common
            config.modules.nixos.user-chtc
          ];
        };
      };
    };
  }
)
