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
    ./plasma
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
