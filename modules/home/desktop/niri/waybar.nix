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
      position = "right";
      spacing = 6;
      width = 24;

      modules-left = [ "clock" ];

      modules-right = [
        "battery"
        "backlight"
        "wireplumber"
        "network"
        "tray"
        "custom/swaync"
      ];

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
        format = "vol: {volume}%";
        format-muted = "vol: muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        rotate = 270;
      };

      network = {
        format-ethernet = "ethernet";
        format-wifi = "wi-fi";
        format-disconnected = "disconnected";
        tooltip-format = "{ifname} via {gwaddr}";
        tooltip-format-ethernet = "{ipaddr}/{cidr} ({ifname})";
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
        on-click = "$TERMINAL -e nmtui";
        rotate = 270;
      };

      backlight = {
        format = "lit: {percent}%";
        on-scroll-up = "brightnessctl set +1%";
        on-scroll-down = "brightnessctl set 1%-";
        rotate = 270;
      };

      battery = {
        format = "bat: {capacity}%";
        format-warning = "bat(w): {capacity}%";
        format-critical = "bat(!): {capacity}%";
        format-charging = "bat(↑): {capacity}%";
        format-plugged = "plugged";
        format-alt = "bat: {time}";
        rotate = 270;

        states = {
          warning = 30;
          critical = 15;
        };
      };

      tray = {
        icon-size = 16;
        spacing = 6;
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
      window#waybar, tooltip {
          background: alpha(${colors.base00}, 1.000000);
      }

      * {
          font-family: ${config.stylix.fonts.sansSerif.name};
          font-size: ${toString config.stylix.fonts.sizes.desktop}pt;
          padding: 0;
      }

      window#waybar, tooltip {
          color: ${colors.base05};
      }

      tooltip {
          border-color: ${colors.base0D};
      }
      #wireplumber,
      #pulseaudio,
      #sndio {
        padding: 6px 0;
      }
      #wireplumber.muted,
      #pulseaudio.muted,
      #sndio.muted {
        padding: 6px 0;
      }
      #upower,
      #battery {
        padding: 6px 0;
      }
      #upower.charging,
      #battery.Charging {
        padding: 6px 0;
      }
      #network {
        padding: 6px 0;
      }
      #network.disconnected {
        padding: 6px 0;
      }
      #user {
        padding: 6px 0;
      }
      #clock {
        padding: 6px 0;
      }
      #backlight {
        padding: 6px 0;
      }
      #cpu {
        padding: 6px 0;
      }
      #disk {
        padding: 6px 0;
      }
      #idle_inhibitor {
        padding: 6px 0;
      }
      #temperature {
        padding: 6px 0;
      }
      #mpd {
        padding: 6px 0;
      }
      #language {
        padding: 6px 0;
      }
      #keyboard-state {
        padding: 6px 0;
      }
      #memory {
        padding: 6px 0;
      }
      #window {
        padding: 6px 0;
      }
      #bluetooth {
        padding: 6px 0;
      }
      #bluetooth.disabled {
        padding: 6px 0;
      }
      .modules-left #workspaces button {
          border-bottom: none;
      }
      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active {
          border-bottom: none;
      }
      .modules-center #workspaces button {
          border-bottom: none;
      }
      .modules-center #workspaces button.focused,
      .modules-center #workspaces button.active {
          border-bottom: none;
      }
      .modules-right #workspaces button {
          border-bottom: none;
      }
      .modules-right #workspaces button.focused,
      .modules-right #workspaces button.active {
          border-bottom: none;
      }
    '';
  };
}
