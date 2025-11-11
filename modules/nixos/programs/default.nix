{ lib, ... }:
{
  imports = [
    ./appimage.nix
    ./bash.nix
    ./zsh.nix
  ];

  programs = {
    less.enable = lib.mkForce false;
    nano.enable = false;
    vim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
