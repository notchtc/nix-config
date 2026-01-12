{ lib, ... }:
{
  imports = [
    ./bash.nix
    ./wine.nix
    ./zsh.nix
  ];

  programs = {
    less.enable = lib.mkForce false;
    nano.enable = false;
  };
}
