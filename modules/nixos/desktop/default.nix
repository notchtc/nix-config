{
  flake,
  pkgs,
  ...
}:
{
  imports = [
    flake.nixosModules.common
    ./boot.nix
    ./niri.nix
    ./pipewire.nix
    ./stylix.nix
  ];

  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  nix.daemonCPUSchedPolicy = "idle";
}
