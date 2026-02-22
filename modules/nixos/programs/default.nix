{ lib, ... }:
{
  imports = [
    ./gui
    ./bash.nix
    ./fluidsynth.nix
    ./zsh.nix
  ];

  programs = {
    less.enable = lib.mkForce false;
    nano.enable = false;
  };
}
