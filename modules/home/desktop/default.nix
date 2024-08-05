{ lib, pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./gtk.nix
    ./mpv.nix
    ./plasma.nix
    ./schizofox.nix
  ];

  home = {
    packages = lib.attrValues { inherit (pkgs) jamesdsp strawberry-qt6; };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
