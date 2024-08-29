{
  flake,
  lib,
  ...
}:
{
  imports = [
    flake.nixosModules.common
    ./plasma.nix
    ./pipewire.nix
    ./fonts.nix
  ];

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
