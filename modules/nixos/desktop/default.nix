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

  nix.daemonCPUSchedPolicy = "idle";
}
