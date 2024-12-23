{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./waybar.nix ];

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = 1;
    NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORM = "wayland";
  };

  programs = {
    fuzzel = {
      enable = true;
      settings = {
        main = {
          icon-theme = "MoreWaita";
          horizontal-pad = 4;
          prompt = "\"λ \"";
          vertical-pad = 4;
        };
        border = {
          width = 2;
          radius = 4;
        };
      };
    };
    hyprlock.enable = true;
  };

  services = {
    swaync = {
      enable = true;

      settings = {
        positionX = "left";
        positionY = "top";

        notification-icon-size = 32;
        notification-body-image-height = 50;
        notification-body-image-width = 100;

        control-center-margin-top = 4;
        control-center-margin-bottom = 4;
        control-center-margin-right = 4;
        control-center-margin-left = 4;

        widgets = [
          "title"
          "dnd"
          "notifications"
          "mpris"
        ];

        widget-config = {
          mpris = {
            image-size = 64;
            image-radius = 4;
          };
        };
      };
    };

    wlsunset = {
      enable = true;
      sunrise = "06:00";
      sunset = "19:30";
      temperature.night = 2500;
    };
  };

  systemd.user.services = {
    swaybg = {
      Unit = {
        Description = "Set wallpaper";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.stylix.image}";
        Restart = "on-failure";
      };
    };

    hypridle.Unit = {
      After = lib.mkForce [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    swaync.Unit = {
      After = lib.mkForce [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    waybar.Unit = {
      After = lib.mkForce [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    wlsunset.Unit = {
      After = lib.mkForce [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };
  };
}
