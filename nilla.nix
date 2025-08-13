let
  pins = import ./npins;
  nilla = import pins.nilla;
  compat = import pins.flake-compat;
  nixpkgs-flake = compat.load { src = pins.nixpkgs; };

  loaders = {
    agenix = "raw";
    nixos-hardware = "raw";
    lix = "raw";
  };

  settings = {
    nixpkgs.configuration.allowUnfree = true;
    disko.inputs.nixpkgs = nixpkgs-flake;
    home-manager.inputs.nixpkgs = nixpkgs-flake;
    nix-index-database.inputs.nixpkgs = nixpkgs-flake;
    openmw-nix.inputs.nixpkgs = nixpkgs-flake;
    schizofox.inputs.nixpkgs = nixpkgs-flake;
    stylix.inputs.nixpkgs = nixpkgs-flake;
  };
in
nilla.create (
  { config }:
  {

    includes = [
      ./homes
      ./lib
      ./systems

      "${pins.nilla-home}/modules/home.nix"
      "${pins.nilla-home}/modules/nixos.nix"
      "${pins.nilla-nixos}/modules/nixos.nix"
    ];

    config = {
      inputs = builtins.mapAttrs (name: pin: {
        src = pin;

        loader = loaders.${name} or config.lib.constants.never;
        settings = settings.${name} or config.lib.constants.never;
      }) pins;

      modules = {
        nilla = {
          homes = ./homes;
          lib = ./lib;
          systems = ./systems;
        };

        nixos = {
          common = ./modules/nixos/common;
          desktop = ./modules/nixos/desktop;
          gaming = ./modules/nixos/gaming;
          laptop = ./modules/nixos/laptop;
          user-chtc = ./modules/nixos/user-chtc;
        };

        home = {
          common = ./modules/home/common;
          desktop = ./modules/home/desktop;
        };
      };

      shells.default = {
        systems = [ "x86_64-linux" ];

        shell =
          {
            mkShell,
            npins,
            system,
          }:
          mkShell {
            packages = [
              config.inputs.nilla-cli.result.packages.nilla-cli.result.${system}
              config.inputs.nilla-home.result.packages.nilla-home.result.${system}
              config.inputs.nilla-nixos.result.packages.nilla-nixos.result.${system}
              npins
            ];
          };
      };
    };
  }
)
