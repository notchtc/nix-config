{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common
    ./ghostty.nix
    ./mpv.nix
    ./schizofox.nix
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        easyeffects
        foliate
        gimp
        keepassxc
        nicotine-plus
        picard
        plugdata
        qbittorrent
        quodlibet-full
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
