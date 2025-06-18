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
      shells.default = {
        systems = [ "x86_64-linux" ];

        shell =
          {
            npins,
            pkgs,
            mkShell,
          }:
          mkShell {
            packages = [
              config.inputs.nilla-cli.result.packages.nilla-cli.result.${pkgs.system}
              config.inputs.nilla-home.result.packages.nilla-home.result.${pkgs.system}
              config.inputs.nilla-nixos.result.packages.nilla-nixos.result.${pkgs.system}
              npins
            ];
          };
      };
    };
  }
)
