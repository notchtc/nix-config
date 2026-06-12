let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create (
  { config }: {
    includes = [
      ./hosts
      ./inputs.nix
      "${pins.nilla-nixos}/modules/nixos.nix"
    ];

    config.shells.default = {
      systems = [ "x86_64-linux" ];

      builder = "nixpkgs";
      settings.pkgs = config.inputs.nixpkgs.result;

      shell =
        {
          deadnix,
          git,
          mkShellNoCC,
          nixfmt,
          nixfmt-tree,
          npins,
          openssh,
          pkgs,
          statix,
          stdenvNoCC,
          ...
        }:
        let
          inherit (stdenvNoCC.hostPlatform) system;
        in
        mkShellNoCC {
          packages = [
            config.inputs.nilla-cli.result.packages.default.result.${system}
            config.inputs.nilla-nixos.result.packages.default.result.${system}

            deadnix
            git
            nixfmt
            nixfmt-tree
            npins
            openssh
            statix
          ];

          shellHook = ''
            export NIX_PATH="nixpkgs=${builtins.storePath pkgs.path}"
          '';
        };
    };
  }
)
