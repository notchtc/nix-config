{ lib, ... }:
{
  imports = [
    ./bash.nix
    ./zsh.nix
  ];

  programs = {
    less.enable = lib.mkForce false;
    nano.enable = false;
  };
}
