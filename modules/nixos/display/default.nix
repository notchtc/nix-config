{ config, lib, ... }:
{
  imports = [
    ./fonts.nix
    ./plasma.nix
    ./variables.nix
  ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    boot.plymouth = {
      enable = true;
      theme = "breeze";
    };

    programs.dconf.enable = true;
    i18n.inputMethod.fcitx5.waylandFrontend = true;
    services = {
      dbus.implementation = "broker";
      kmscon = {
        enable = true;
        hwRender = true;
        extraConfig = ''
          xkb-layout=${config.mama.system.keyMap}
        '';
      };
    };
  };
}
