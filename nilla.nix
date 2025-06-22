let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create (
  { config }:
  {

    includes = [
      ./homes
      ./lib
      ./systems
      ./inputs.nix

      "${pins.nilla-home}/modules/home.nix"
      "${pins.nilla-home}/modules/nixos.nix"
      "${pins.nilla-nixos}/modules/nixos.nix"
    ];

    config = {
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
            npins,
            mkShell,
          }:
          mkShell {
            packages = [
              config.inputs.nilla-cli.result.packages.nilla-cli.result.${config.nixpkgs.hostPlatform.system}
              config.inputs.nilla-home.result.packages.nilla-home.result.${config.nixpkgs.hostPlatform.system}
              config.inputs.nilla-nixos.result.packages.nilla-nixos.result.${config.nixpkgs.hostPlatform.system}
              npins
            ];
          };
      };
    };
  }
)
