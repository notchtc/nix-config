let
  pins = import ./npins;
  nilla = import pins.nilla;
  nlib = import "${pins.nixpkgs}/lib";
in
nilla.create (
  { config, lib }:
  let
    inherit (builtins) filter;
    inherit (lib.strings) hasSuffix;
    inherit (nlib.filesystem) listFilesRecursive;
  in
  {
    includes = [
      ./hosts
      ./inputs.nix

      "${pins.nilla-nixos}/modules/nixos.nix"
    ]
    ++ filter (hasSuffix ".nix") (listFilesRecursive ./modules);

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
        };
    };
  }
)
