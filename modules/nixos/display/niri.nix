{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.niri.result.nixosModules.niri ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services.greetd = {
      enable = true;
      useTextGreeter = true;

      settings = {
        default_session = {
          user = "greeter";
          command = "${pkgs.tuigreet}/bin/tuigreet -i -t -c ${pkgs.niri}/bin/niri-session";
        };

        initial_session = {
          command = "${pkgs.niri}/bin/niri-session";
          user = "${config.services.displayManager.autoLogin.user}";
        };
      };
    };

    xdg.portal = {
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = "gtk";
        "org.freedesktop.impl.portal.Notification" = "gtk";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
    };

    systemd.user.services.niri-flake-polkit.enable = false;
    security = {
      soteria.enable = true;
      pam.services.greetd.enableGnomeKeyring = true;
    };
  };
}
