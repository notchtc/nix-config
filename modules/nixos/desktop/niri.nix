{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.niri.result.nixosModules.niri ];
  nixpkgs.overlays = [ inputs.niri.result.overlays.niri ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      libnotify
      libsecret
      wl-clipboard
      xwayland-satellite-unstable
      ;
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services = {
    devmon.enable = true;
    gvfs.enable = true;
    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -i -t  -c ${pkgs.niri-unstable}/bin/niri-session";
          user = "greeter";
        };
        initial_session = lib.mkIf config.services.displayManager.autoLogin.enable {
          command = "${pkgs.niri-unstable}/bin/niri-session";
          user = "${config.services.displayManager.autoLogin.user}";
        };
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

  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    hyprlock = { };
  };
}
