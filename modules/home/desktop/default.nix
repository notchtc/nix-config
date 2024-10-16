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
        file-roller
        gimp
        keepassxc
        nautilus
        nicotine-plus
        papers
        picard
        qbittorrent
        quodlibet-full
        telegram-desktop
        vesktop
        ;
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  services = {
    easyeffects.enable = true;
  };
}
