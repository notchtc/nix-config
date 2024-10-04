{ lib, pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./gtk.nix
    ./mpv.nix
    ./plasma
    ./schizofox.nix
  ];

  home = {
    packages = lib.attrValues { inherit (pkgs) strawberry-qt6; };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  services = {
    easyeffects.enable = true;

    remmina = {
      enable = true;
      systemdService.enable = false;
    };
  };
}
