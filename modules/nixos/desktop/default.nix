{
  flake,
  ...
}:
{
  imports = [
    flake.nixosModules.common
    ./niri.nix
    ./pipewire.nix
    ./stylix.nix
  ];
}
