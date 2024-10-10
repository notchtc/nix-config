{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common

    ./alacritty.nix
    ./gtk.nix
    ./niri.nix
    ./mpv.nix
    #    ./plasma
    ./qt.nix
    ./schizofox.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        gimp
        keepassxc
        nicotine-plus
        picard
        qbittorrent
        strawberry-qt6
        telegram-desktop
        vesktop
        ;
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  services = {
    easyeffects.enable = true;
  };
}
