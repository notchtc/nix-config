{
  config,
  lib,
  osConfig,
  pkgs,
  profiles,
  ...
}:
{
  programs.niri.settings = lib.mkIf profiles.graphical.enable {
    input.keyboard.xkb.layout = osConfig.mama.system.keyMap;

    layout = {
      gaps = 8;

      border.enable = false;

      focus-ring = with config.lib.stylix.colors.withHashtag; {
        enable = true;
        width = 4;

        active.color = base0D;
        inactive.color = base0F;
      };

      struts = {
        left = 8;
        right = 8;
      };
    };

    cursor.hide-after-inactive-ms = 5000;
    hotkey-overlay.skip-at-startup = true;
    prefer-no-csd = true;

    layer-rules = [
      {
        matches = [ { namespace = "^noctalia-overview*"; } ];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      {
        draw-border-with-background = false;
        clip-to-geometry = true;
        geometry-corner-radius =
          let
            r = 8.0;
          in
          {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
      }
      {
        matches = [ { app-id = "^org.keepassxc.KeePassXC$"; } ];
        block-out-from = "screencast";
      }
      {
        matches = [
          {
            app-id = "firefox$";
            title = "^Picture-in-Picture$";
          }
          {
            app-id = "^org.telegram.desktop$";
            title = "^Media viewer$";
          }
        ];
        open-floating = true;
      }
    ];

    binds = with config.lib.niri.actions; {
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+Return" = {
        action = spawn "${config.home.sessionVariables.TERMINAL}";
        hotkey-overlay.title = "Open Terminal";
      };
      "Mod+Space" = {
        action = spawn "vicinae" "toggle";
        hotkey-overlay.title = "Toggle Vicinae";
      };

      "XF86AudioRaiseVolume" = {
        action = spawn "noctalia-shell" "ipc" "call" "volume" "increase";
        allow-when-locked = true;
      };

      "XF86AudioLowerVolume" = {
        action = spawn "noctalia-shell" "ipc" "call" "volume" "decrease";
        allow-when-locked = true;
      };

      "XF86AudioMute" = {
        action = spawn "noctalia-shell" "ipc" "call" "volume" "muteOutput";
        allow-when-locked = true;
      };

      "XF86AudioMicMute" = {
        action = spawn "noctalia-shell" "ipc" "call" "volume" "muteInput";
        allow-when-locked = true;
      };

      "XF86MonBrightnessUp" = {
        action = spawn "noctalia-shell" "ipc" "call" "brightness" "increase";
        allow-when-locked = true;
      };

      "XF86MonBrightnessDown" = {
        action = spawn "noctalia-shell" "ipc" "call" "brightness" "decrease";
        allow-when-locked = true;
      };

      "XF86AudioPrev" = {
        action = spawn "noctalia-shell" "ipc" "call" "media" "previous";
        allow-when-locked = true;
      };

      "XF86AudioNext" = {
        action = spawn "noctalia-shell" "ipc" "call" "media" "next";
        allow-when-locked = true;
      };

      "XF86AudioPlay" = {
        action = spawn "noctalia-shell" "ipc" "call" "media" "playPause";
        allow-when-locked = true;
      };

      "Mod+O" = {
        action = toggle-overview;
        repeat = false;
      };

      "Mod+Q" = {
        action = close-window;
        repeat = false;
      };

      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+L".action = focus-column-right;

      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
      "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
      "Mod+Ctrl+L".action = move-column-right;

      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;

      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;
      "Mod+Shift+L".action = focus-monitor-right;

      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+U".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+I".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

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
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Ctrl+F".action = expand-column-to-available-width;
      "Mod+C".action = center-column;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";

      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+V".action = switch-focus-between-floating-and-tiling;
      "Mod+Shift+V".action = toggle-window-floating;

      "Mod+W".action = toggle-column-tabbed-display;

      "Print".action.screenshot-screen = [ ];
      "Shift+Print".action.screenshot = [ ];
      "Ctrl+Print".action.screenshot-window = [ ];

      "Mod+Insert".action = set-dynamic-cast-window;
      "Mod+Shift+Insert".action = set-dynamic-cast-monitor;
      "Mod+Delete".action = clear-dynamic-cast-target;

      "Mod+Escape" = {
        action = toggle-keyboard-shortcuts-inhibit;
        allow-inhibiting = false;
      };

      "Mod+Shift+P".action = power-off-monitors;
    };

    spawn-at-startup = [ { command = [ "noctalia-shell" ]; } ];

    screenshot-path = "${config.xdg.userDirs.pictures}/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    xwayland-satellite.path = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";

    debug = {
      honor-xdg-activation-with-invalid-serial = [ ];
    };
  };
}
