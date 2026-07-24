{
  config.modules = {
    nixos.niri =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib.meta) getExe getExe';
        inherit (lib.modules) mkIf;
      in
      {
        programs.niri = {
          enable = true;
          useNautilus = false;
        };

        services.greetd = {
          enable = true;
          useTextGreeter = true;

          settings = {
            default_session = {
              user = "greeter";
              command = "${getExe pkgs.tuigreet} -i -t -c '${getExe' pkgs.niri "niri-session"} -l'";
            };

            initial_session = mkIf (config.services.displayManager.autoLogin.user != null) {
              command = "${getExe' pkgs.niri "niri-session"} -l";
              user = "${config.services.displayManager.autoLogin.user}";
            };
          };
        };

        security.pam.services.greetd.enableGnomeKeyring = true;
      };

    home.niri =
      {
        config,
        lib,
        osConfig,
        pkgs,
        ...
      }:
      let
        inherit (lib.meta) getExe;
      in
      {
        xdg.config.files."niri/config.kdl".text = ''
          input {
            keyboard {
              xkb {
                layout "${osConfig.console.keyMap}"
                  model ""
                  rules ""
                  variant ""
              }
              repeat-delay 600
              repeat-rate 25
              track-layout "global"
              }
            touchpad {
              tap
              natural-scroll
            }
          }

          layout {
            gaps 4
            default-column-width
            center-focused-column "never"
            border {
              off
            }
            focus-ring {
              width 2
              active-color "#3daee9"
              inactive-color "#232627"
              urgent-color "#ed1515"
            }
            struts {
              left 4
              right 4
              top 0
              bottom 0
            }
          }

          recent-windows {
            highlight {
              active-color "#3daee9"
              urgent-color "#ed1515"
              corner-radius 8
            }
          }

          cursor {
            xcursor-theme "${config.environment.sessionVariables.XCURSOR_THEME}"
            xcursor-size ${toString config.environment.sessionVariables.XCURSOR_SIZE}
            hide-after-inactive-ms 5000
          }

          window-rule {
            draw-border-with-background false
            clip-to-geometry true
            geometry-corner-radius 8
          }

          window-rule {
            match app-id="^org.keepassxc.KeePassXC$"
            block-out-from "screencast"
          }

          window-rule {
            match app-id="firefox$" title="^Picture-in-Picture$"
            match app-id="librewolf$" title="^Picture-in-Picture$"
            match app-id="^org.telegram.desktop$" title="^Media viewer$"
            open-floating true
          }

          window-rule {
            match app-id="dev.noctalia.Noctalia"
            open-floating true
            default-column-width { fixed 1080; }
            default-window-height { fixed 920; }
          }

          binds {
            Ctrl+Print  {screenshot-window;}
            Mod+1  {focus-workspace 1;}
            Mod+2  {focus-workspace 2;}
            Mod+3  {focus-workspace 3;}
            Mod+4  {focus-workspace 4;}
            Mod+5  {focus-workspace 5;}
            Mod+6  {focus-workspace 6;}
            Mod+7  {focus-workspace 7;}
            Mod+8  {focus-workspace 8;}
            Mod+9  {focus-workspace 9;}
            Mod+BracketLeft  {consume-or-expel-window-left;}
            Mod+BracketRight  {consume-or-expel-window-right;}
            Mod+C  {center-column;}
            Mod+Comma  {consume-window-into-column;}
            Mod+Ctrl+1  {move-column-to-workspace 1;}
            Mod+Ctrl+2  {move-column-to-workspace 2;}
            Mod+Ctrl+3  {move-column-to-workspace 3;}
            Mod+Ctrl+4  {move-column-to-workspace 4;}
            Mod+Ctrl+5  {move-column-to-workspace 5;}
            Mod+Ctrl+6  {move-column-to-workspace 6;}
            Mod+Ctrl+7  {move-column-to-workspace 7;}
            Mod+Ctrl+8  {move-column-to-workspace 8;}
            Mod+Ctrl+9  {move-column-to-workspace 9;}
            Mod+Ctrl+End  {move-column-to-last;}
            Mod+Ctrl+F  {expand-column-to-available-width;}
            Mod+Ctrl+H  {move-column-left;}
            Mod+Ctrl+Home  {move-column-to-first;}
            Mod+Ctrl+J  {move-window-down-or-to-workspace-down;}
            Mod+Ctrl+K  {move-window-up-or-to-workspace-up;}
            Mod+Ctrl+L  {move-column-right;}
            Mod+Ctrl+R  {reset-window-height;}
            Mod+Ctrl+Shift+WheelScrollDown  {move-column-right;}
            Mod+Ctrl+Shift+WheelScrollUp  {move-column-left;}
            Mod+Ctrl+WheelScrollDown cooldown-ms=150 {move-column-to-workspace-down;}
            Mod+Ctrl+WheelScrollLeft  {move-column-left;}
            Mod+Ctrl+WheelScrollRight  {move-column-right;}
            Mod+Ctrl+WheelScrollUp cooldown-ms=150 {move-column-to-workspace-up;}
            Mod+Delete  {clear-dynamic-cast-target;}
            Mod+End  {focus-column-last;}
            Mod+Equal  {set-column-width "+10%";}
            Mod+Escape allow-inhibiting=false {toggle-keyboard-shortcuts-inhibit;}
            Mod+F  {maximize-column;}
            Mod+H  {focus-column-left;}
            Mod+Home  {focus-column-first;}
            Mod+Insert  {set-dynamic-cast-window;}
            Mod+J  {focus-window-or-workspace-down;}
            Mod+K  {focus-window-or-workspace-up;}
            Mod+L  {focus-column-right;}
            Mod+Minus  {set-column-width "-10%";}
            Mod+O repeat=false {toggle-overview;}
            Mod+Period  {expel-window-from-column;}
            Mod+Q repeat=false {close-window;}
            Mod+R  {switch-preset-column-width;}
            Mod+Return hotkey-overlay-title="Open Terminal" {spawn "ghostty" "--gtk-single-instance=true";}
            Mod+Shift+Ctrl+H  {move-column-to-monitor-left;}
            Mod+Shift+Ctrl+I  {move-column-to-monitor-up;}
            Mod+Shift+Ctrl+L  {move-column-to-monitor-right;}
            Mod+Shift+Ctrl+U  {move-column-to-monitor-down;}
            Mod+Shift+Equal  {set-window-height "+10%";}
            Mod+Shift+F  {fullscreen-window;}
            Mod+Shift+H  {focus-monitor-left;}
            Mod+Shift+Insert  {set-dynamic-cast-monitor;}
            Mod+Shift+J  {focus-monitor-down;}
            Mod+Shift+K  {focus-monitor-up;}
            Mod+Shift+L  {focus-monitor-right;}
            Mod+Shift+Minus  {set-window-height "-10%";}
            Mod+Shift+P  {power-off-monitors;}
            Mod+Shift+R  {switch-preset-window-height;}
            Mod+Shift+Slash  {show-hotkey-overlay;}
            Mod+Shift+V  {toggle-window-floating;}
            Mod+Shift+WheelScrollDown  {focus-column-right;}
            Mod+Shift+WheelScrollUp  {focus-column-left;}
            Mod+Space hotkey-overlay-title="Toggle launcher" {spawn "noctalia" "msg" "panel-toggle" "launcher";}
            Mod+V  {switch-focus-between-floating-and-tiling;}
            Mod+W  {toggle-column-tabbed-display;}
            Mod+WheelScrollDown cooldown-ms=150 {focus-workspace-down;}
            Mod+WheelScrollLeft  {focus-column-left;}
            Mod+WheelScrollRight  {focus-column-right;}
            Mod+WheelScrollUp cooldown-ms=150 {focus-workspace-up;}
            Print  {screenshot-screen;}
            Shift+Print  {screenshot;}
            XF86AudioLowerVolume allow-when-locked=true {spawn "noctalia" "msg" "volume-down";}
            XF86AudioMicMute allow-when-locked=true {spawn "noctalia" "msg" "mic-mute";}
            XF86AudioMute allow-when-locked=true {spawn "noctalia" "msg" "volume-mute";}
            XF86AudioNext allow-when-locked=true {spawn "noctalia" "msg" "media" "next";}
            XF86AudioPlay allow-when-locked=true {spawn "noctalia" "msg" "media" "toggle";}
            XF86AudioPrev allow-when-locked=true {spawn "noctalia" "msg" "media" "previous";}
            XF86AudioRaiseVolume allow-when-locked=true {spawn "noctalia" "msg" "volume-up";}
            XF86MonBrightnessDown allow-when-locked=true {spawn "noctalia" "msg" "brightness-down";}
            XF86MonBrightnessUp allow-when-locked=true {spawn "noctalia" "msg" "brightness-up";}
          }

          debug {
            enable-overlay-planes
            honor-xdg-activation-with-invalid-serial
          }

          hotkey-overlay { skip-at-startup; }
          prefer-no-csd
          screenshot-path "${config.directory}/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
          xwayland-satellite { path "${getExe pkgs.xwayland-satellite}"; }

          spawn-at-startup "noctalia"
        '';
      };
  };
}
