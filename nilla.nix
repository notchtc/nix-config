let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create {
  includes = [
    ./hosts
    ./inputs.nix
    "${pins.nilla-nixos}/modules/nixos.nix"
  ];
}
