{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common
    ./ghostty.nix
    ./gnome.nix
    ./mpv.nix
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        easyeffects
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
