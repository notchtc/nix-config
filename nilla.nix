let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create {
  includes = [
    ./hosts
    ./inputs.nix
    ./packages
    "${pins.nilla-nixos}/modules/nixos.nix"
  ];
}
