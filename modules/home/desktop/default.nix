{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common
    #    ./alacritty.nix
    ./foot.nix
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
        _64gram
        gimp
        keepassxc
        nicotine-plus
        pcmanfm
        picard
        qbittorrent
        quodlibet-full
        vesktop
        xarchiver
        ;

      papers = pkgs.papers.override { supportNautilus = false; };
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  services = {
    easyeffects.enable = true;
  };
}
