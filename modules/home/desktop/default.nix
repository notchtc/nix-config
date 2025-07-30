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
        fooyin
        gimp3
        nautilus
        nicotine-plus
        papers
        picard
        plugdata
        qbittorrent
        telegram-desktop
        ;
    };

    file."${config.xdg.configHome}/fooyin/layout.fyl".source = ./layout.fyl;

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland";
    };
  };

  programs = {
    foliate.enable = true;
    keepassxc.enable = true;
    swayimg.enable = true;
    vesktop.enable = true;
  };
}
