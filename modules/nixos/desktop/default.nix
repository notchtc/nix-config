{
  flake,
  ...
}:
{
  imports = [
    flake.nixosModules.common
    ./niri.nix
    ./pipewire.nix
    #    ./plasma.nix
    ./stylix.nix
  ];
}
