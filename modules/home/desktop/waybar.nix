{ config, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      reload_style_on_change = true;

      layer = "top";
      position = "left";
      spacing = 8;
      width = 20;

      modules-left = [
        "niri/workspaces"
        "clock"
      ];
      modules-right = [
        "wireplumber"
        "battery"
        "network"
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
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 4;
          on-scroll = 1;
          format = {
            months = "<span color='${colors.base07}'><b>{}</b></span>";
            days = "<span color='${colors.base07}'><b>{}</b></span>";
            weekdays = "<span color='${colors.base0C}'><b>{}</b></span>";
            today = "<span color='${colors.base0C}'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
        rotate = 270;
      };

      wireplumber = {
        format = "v: {volume}%";
        format-muted = "muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        rotate = 270;
      };

      network = {
        format = "{ifname}";
        format-ethernet = "eth";
        format-wifi = "wi-fi";
        format-disconnected = "disconnected";
        tooltip-format = "{ifname} via {gwaddr}";
        tooltip-format-ethernet = "{ipaddr}/{cidr} ({ifname})";
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
        on-click = "foot -e nmtui";
        rotate = 270;
      };

      battery = {
        format = "b: {capacity}%";
        rotate = 270;
      };

      tray = {
        icon-size = 16;
        spacing = 4;
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
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        margin: 0;
        padding: 0;
        font-family: ${config.stylix.fonts.sansSerif.name};
        font-size: ${toString config.stylix.fonts.sizes.desktop}pt; 
        min-height: 0;
        background: ${colors.base01};
        color: ${colors.base07};
      }

      tooltip {
        border: 2px solid ${colors.base0D};
        border-radius: 4px;
      }

      .modules-left, .modules-right {
        padding: 8px 0px;
      }

      #wireplumber.muted {
        color: ${colors.base04};
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: transparent;
        color: shade(${colors.base07}, 1.5);
      }

      #workspaces button.focused, #workspaces button.active {
        color: ${colors.base0D};
      }

      #workspaces button.focused:hover, #workspaces button.active:hover {
        color: shade(${colors.base0D}, 1.5);
      }

      #workspaces button.urgent {
        color: ${colors.base08};
      }

      #workspaces button.urgent:hover {
        color: shade(${colors.base08}, 1.5);
      }

      #battery.warning:not(.charging) {
        color: ${colors.base0A};
      }

      #battery.critical:not(.charging) {
        color: ${colors.base08};
      }

      #tray menu * { background: transparent; }
      #tray menu *:hover {
        background: ${colors.base02};
        color: shade(${colors.base07}, 1.5);
      }
    '';
  };
}
