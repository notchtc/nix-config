{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.niri.result.nixosModules.niri ];
  config = lib.mkIf config.mama.desktops.niri.enable {
    nixpkgs.overlays = [ inputs.niri.result.overlays.niri ];
    environment.systemPackages = lib.attrValues { inherit (pkgs) libnotify libsecret wl-clipboard; };

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet -i -t  -c ${pkgs.niri}/bin/niri-session";
          user = "greeter";
        };
        initial_session = lib.mkIf config.services.displayManager.autoLogin.enable {
          command = "${pkgs.niri}/bin/niri-session";
          user = "${config.services.displayManager.autoLogin.user}";
        };
      };
    };

    xdg.portal = {
      enable = true;
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

    security.pam.services = {
      greetd.enableGnomeKeyring = true;
      hyprlock = { };
    };
  };
}
