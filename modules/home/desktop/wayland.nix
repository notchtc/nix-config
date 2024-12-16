{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./waybar.nix ];

  programs = {
    fuzzel = {
      enable = true;
      settings = {
        main = {
          icon-theme = "MoreWaita";
          horizontal-pad = 6;
          prompt = "\"λ \"";
          vertical-pad = 6;
        };
        border = {
          width = 3;
          radius = 6;
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

        control-center-margin-top = 6;
        control-center-margin-bottom = 6;
        control-center-margin-right = 6;
        control-center-margin-left = 6;

        widgets = [
          "title"
          "dnd"
          "notifications"
          "mpris"
        ];

        widget-config = {
          mpris = {
            image-size = 64;
            image-radius = 3;
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
