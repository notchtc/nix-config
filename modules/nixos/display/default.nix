{ config, lib, ... }:
{
  imports = [
    ./fonts.nix
    ./gnome.nix
    ./plasma.nix
    ./services.nix
    ./variables.nix
  ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    boot.plymouth.enable = true;
    programs.dconf.enable = true;
    i18n.inputMethod.fcitx5.waylandFrontend = true;
  };
}
