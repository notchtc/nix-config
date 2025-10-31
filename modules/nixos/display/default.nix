{ config, lib, ... }:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
in
{
  imports = [
    ./fonts.nix
    ./gnome.nix
    ./plasma.nix
    ./services.nix
    ./variables.nix
  ];

  config = mkIf graphical {
    boot.plymouth.enable = true;
    programs.dconf.enable = true;
    i18n.inputMethod.fcitx5.waylandFrontend = true;
  };
}
