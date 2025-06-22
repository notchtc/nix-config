{ inputs }:
{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./ghostty.nix
    ./gnome.nix
    ./mpv.nix
    (import ./schizofox.nix { inherit inputs; })
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        foliate
        gimp3
        keepassxc
        nicotine-plus
        picard
        plugdata
        qbittorrent
        strawberry
        telegram-desktop
        vesktop
        ;
    };

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland";
    };
  };
}
