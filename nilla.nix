let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create (
  { config }:
  {

    includes = [
      ./hosts
      ./inputs.nix

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
              config.inputs.nilla-nixos.result.packages.nilla-nixos.result.${pkgs.system}
              npins
            ];
          };
      };
    };
  }
)
