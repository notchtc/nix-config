{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common
    ./foot.nix
    ./mpv.nix
    ./schizofox.nix
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        foliate
        gimp
        keepassxc
        nicotine-plus
        picard
        plugdata
        qbittorrent
        strawberry-qt6
        telegram-desktop
        vesktop
        ;
    };

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland";
    };
  };

  services = {
    easyeffects.enable = true;
  };
}
