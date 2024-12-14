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
    ./niri.nix
    ./mpv.nix
    ./schizofox.nix
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        file-roller
        foliate
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
    udiskie.enable = true;
  };
}
