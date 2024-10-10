{ config, ... }:
{
  imports = [
    ./waybar.nix
  ];

  programs = {
    niri.settings = {
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;

      environment = {
        DISPLAY = ":0";
      };

      cursor = {
        size = 24;
        theme = "phinger-cursors-dark";
      };

      input.keyboard = {
        xkb = {
          layout = "pl";
          options = "caps:swapescape";
        };
        repeat-delay = 485;
        repeat-rate = 37;
      };

      layout = {
        gaps = 6;

        focus-ring = {
          enable = false;
        };

        border = {
          enable = true;
          width = 3;
        };

        struts = {
          left = 3;
          right = 3;
          top = 3;
          bottom = 3;
        };
      };

      window-rules = [
        {
          draw-border-with-background = false;
          geometry-corner-radius =
            let
              r = 6.0;
            in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
          clip-to-geometry = true;
        }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Mod+Return".action =
          spawn "sh" "-c"
            "alacritty msg create-window --working-directory ~ || alacritty";
        "Mod+D".action = spawn "fuzzel";
        "Mod+Alt+L".action = spawn "swaylock";
        "Mod+Alt+E".action = spawn "shutdown" "-h" "now";

        "XF86AudioRaiseVolume" = {
          action = spawn "wpctl" "set-volume" "-l" "1.0" "@DEFAULT_AUDIO_SINK@" "0.1+";
          allow-when-locked = true;
        };

        "XF86AudioLowerVolume" = {
          action = spawn "wpctl" "set-volume" "-l" "1.0" "@DEFAULT_AUDIO_SINK@" "0.1-";
          allow-when-locked = true;
        };

        "XF86AudioMute" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          allow-when-locked = true;
        };

        "XF86AudioMicMute" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };

        "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "10%+";
        "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "10%-";

        "XF86AudioPrev".action = spawn "playerctl" "previous";
        "XF86AudioNext".action = spawn "playerctl" "next";
        "XF86AudioPlay".action = spawn "playerctl" "play-pause";

        "Mod+Q".action = close-window;

        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+L".action = focus-column-right;

        "Mod+Tab".action = focus-window-down-or-column-right;
        "Mod+Shift+Tab".action = focus-window-up-or-column-left;

        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+U".action = move-window-down;
        "Mod+Ctrl+I".action = move-window-up;
        "Mod+Ctrl+L".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+U".action = focus-monitor-down;
        "Mod+Shift+I".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+U".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+I".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        "Mod+Ctrl+J".action = move-column-to-workspace-down;
        "Mod+Ctrl+K".action = move-column-to-workspace-up;

        "Mod+Shift+J".action = move-workspace-down;
        "Mod+Shift+K".action = move-workspace-up;

        "Mod+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };

        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+Ctrl+1".action = move-column-to-workspace 1;
        "Mod+Ctrl+2".action = move-column-to-workspace 2;
        "Mod+Ctrl+3".action = move-column-to-workspace 3;
        "Mod+Ctrl+4".action = move-column-to-workspace 4;
        "Mod+Ctrl+5".action = move-column-to-workspace 5;
        "Mod+Ctrl+6".action = move-column-to-workspace 6;
        "Mod+Ctrl+7".action = move-column-to-workspace 7;
        "Mod+Ctrl+8".action = move-column-to-workspace 8;
        "Mod+Ctrl+9".action = move-column-to-workspace 9;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Print".action = screenshot-screen;
        "Shift+Print".action = screenshot;
        "Ctrl+Print".action = screenshot-window;

        "Mod+Shift+E".action = quit;

        "Mod+Shift+P".action = power-off-monitors;
      };

      spawn-at-startup = [
        {
          command = [
            "swaybg"
            "-m"
            "fill"
            "-i"
            "${config.stylix.image}"
          ];
        }
        {
          command = [
            "sh"
            "-c"
            "pidof waybar || waybar"
          ];
        }
        {
          command = [
            "sh"
            "-c"
            "pidof swaync || swaync"
          ];
        }
        {
          command = [ "xwayland-satellite" ];
        }
      ];
    };

    fuzzel.enable = true;
    swaylock.enable = true;
  };

  services.swaync = {
    enable = true;

    settings = {
      positionX = "left";
      positionY = "top";
      notification-icon-size = 32;
      notification-body-image-height = 50;
      notification-body-image-width = 100;
    };
  };
}
