{ lib, ... }:
{
  imports = [
    ./bash.nix
    ./fluidsynth.nix
    ./gamescope.nix
    ./heroic.nix
    ./niri.nix
    ./openmw.nix
    ./steam.nix
    ./zsh.nix
  ];

  programs = {
    less.enable = lib.mkForce false;
    nano.enable = false;
  };
}
