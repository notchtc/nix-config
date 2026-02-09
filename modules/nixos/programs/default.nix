{ lib, ... }:
{
  imports = [
    ./bash.nix
    ./thunar.nix
    ./wine.nix
    ./zsh.nix
  ];

  programs = {
    less.enable = lib.mkForce false;
    nano.enable = false;
  };
}
