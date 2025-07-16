{ inputs }:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./ghostty.nix
    ./mpv.nix
    ./niri
    (import ./schizofox.nix { inherit inputs; })
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        foliate
        fooyin
        gimp3
        keepassxc
        nautilus
        nicotine-plus
        papers
        picard
        plugdata
        qbittorrent
        swayimg
        telegram-desktop
        vesktop
        ;
    };

    file."${config.xdg.configHome}/fooyin/layout.fyl".source = ./layout.fyl;

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland";
    };
  };
}
