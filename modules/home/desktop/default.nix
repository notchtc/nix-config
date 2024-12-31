{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common
    ./foot.nix
    ./niri.nix
    ./mpv.nix
    ./schizofox.nix
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        foliate
        gimp
        imv
        keepassxc
        nicotine-plus
        picard
        qbittorrent
        strawberry-qt6
        telegram-desktop
        vesktop
        ;
    };
  };

  services = {
    easyeffects.enable = true;
  };
}
