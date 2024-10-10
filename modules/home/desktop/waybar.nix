{ config, ... }:
{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      reload_style_on_change = true;

      layer = "top";
      position = "left";
      width = 21;

      modules-left = [
        "niri/workspaces"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "wireplumber"
        "custom/separator"
        "battery"
        "custom/separator"
        "network"
        "custom/separator"
        "tray"
        "custom/swaync"
      ];

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          "active" = "◍";
          "default" = "○";
          "focused" = "●";
        };
      };

      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%d %B %Y %H:%M}";
        tooltip = false;
        rotate = 270;
      };

      wireplumber = {
        format = "vol: {volume}%";
        format-muted = "muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        rotate = 270;
      };

      network = {
        format = "{ifname}";
        format-ethernet = "ethernet";
        format-wifi = "wi-fi";
        format-disconnected = "disconnected";
        tooltip-format = "{ifname} via {gwaddr}";
        tooltip-format-ethernet = "{ipaddr}/{cidr} ({ifname})";
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
        on-click = "alacritty -e nmtui";
        rotate = 270;
      };

      battery = {
        format = "bat: {capacity}%";
        rotate = 270;
      };

      tray = {
        icon-size = 16;
        spacing = 3;
      };

      "custom/swaync" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "●";
          none = "○";
          dnd-notification = "◍";
          dnd-none = "◌";
          inhibited-notification = "●";
          inhibited-none = "○";
          dnd-inhibited-notification = "◍";
          dnd-inhibited-none = "◌";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };

      "custom/separator" = {
        format = "/";
        interval = "once";
        tooltip = false;
        rotate = 270;
      };
    };

    style =
      let
        colors = config.lib.stylix.colors;
      in
      ''
        * {
          border: none;
          border-radius: 0;
          margin: 0;
          padding: 0;
          font-family: ${config.stylix.fonts.sansSerif.name};
          font-size: ${toString config.stylix.fonts.sizes.desktop}pt; 
          min-height: 0;
        }

        window#waybar, tooltip {
          background: #${colors.base00};
          color: #${colors.base07};
        }

        tooltip {
          border: 3px solid #${colors.base0D};
          border-radius: 6px;
        }

        #battery,
        #clock,
        #network,
        #tray,
        #wireplumber {
          padding: 3px 0px 3px 0px;
        }

        #custom-separator {
          padding: 3px 0px 3px 0px;
        }

        #wireplumber.muted {
          color: #${colors.base04};
        }

        #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          background: transparent;
          color: shade(#${colors.base07}, 1.25);
        }

        #workspaces {
          padding: 6px 0px 6px 0px;
        }

        #workspaces button.focused, #workspaces button.active {
          color: #${colors.base0D};
        }

        #workspaces button.urgent {
          color: #${colors.base08};
        }

        #battery.warning:not(.charging) {
          color: #${colors.base0A};
        }

        #battery.critical:not(.charging) {
          color: #${colors.base08};
        }
      '';
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 120;
        command = "swaylock";
      }
      {
        timeout = 240;
        command = "niri msg action power-off-monitors";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
    ];
  };
}
