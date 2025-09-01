{ lib, pkgs, ... }:
{
  imports = [
    ./desktops/niri
    ./programs
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        file-roller
        gimp3
        pcmanfm
        nicotine-plus
        papers
        picard
        plugdata
        pwvucontrol
        qbittorrent
        strawberry
        telegram-desktop
        ;
    };
  };

  services.playerctld.enable = true;
  programs = {
    foliate.enable = true;
    keepassxc.enable = true;
    swayimg.enable = true;
  };
}
