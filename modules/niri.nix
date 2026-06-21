{
  config.modules = {
    nixos.niri =
      {
        config,
        lib,
        modules,
        pkgs,
        ...
      }:
      let
        inherit (lib.meta) getExe getExe';
        inherit (lib.modules) mkForce mkIf;
      in
      {
        programs.niri = {
          enable = true;
          package = pkgs.niri;
        };

        services.greetd = {
          enable = true;
          useTextGreeter = true;

          settings = {
            default_session = {
              user = "greeter";
              command = "${getExe pkgs.tuigreet} -i -t -c ${getExe' pkgs.niri "niri-session"}";
            };

            initial_session = mkIf (config.services.displayManager.autoLogin.user != null) {
              command = getExe' pkgs.niri "niri-session";
              user = "${config.services.displayManager.autoLogin.user}";
            };
          };
        };

        systemd.user.services.niri-flake-polkit.enable = mkForce false;
        security.pam.services.greetd.enableGnomeKeyring = true;

        hjem.extraModules = [ modules.home.niri ];
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
        inherit (lib.modules) mkForce;
      in
      {
        rum.desktops.niri = {
          enable = true;
          package = mkForce null;

          config = ''
            include "dms/alttab.kdl"
            include "dms/colors.kdl"
            include "dms/layout.kdl"
            include "dms/outputs.kdl"
            include "dms/wpblur.kdl"

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
            screenshot-path "${config.directory}/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
            prefer-no-csd
            layout {
              struts {
                left 4
                right 4
                top 0
                bottom 0
              }
              default-column-width
              center-focused-column "never"
            }
            cursor {
              xcursor-theme "${config.environment.sessionVariables.XCURSOR_THEME}"
              xcursor-size ${toString config.environment.sessionVariables.XCURSOR_SIZE}
              hide-after-inactive-ms 5000
            }
            hotkey-overlay { skip-at-startup; }
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
            xwayland-satellite { path "${getExe pkgs.xwayland-satellite}"; }
            debug {
                enable-overlay-planes
                honor-xdg-activation-with-invalid-serial
            }
          '';

          binds = {
            "Mod+Shift+Slash".action = "show-hotkey-overlay";
            "Mod+Return" = {
              spawn = [
                "ghostty"
                "--gtk-single-instance=true"
              ];
              parameters.hotkey-overlay-title = "Open Terminal";
            };
            "Mod+Space" = {
              spawn = [
                "dms"
                "ipc"
                "spotlight"
                "toggle"
              ];
              parameters.hotkey-overlay-title = "Toggle launcher";
            };

            "XF86AudioRaiseVolume" = {
              spawn = [
                "dms"
                "ipc"
                "audio"
                "increment"
                "5"
              ];
              parameters.allow-when-locked = true;
            };

            "XF86AudioLowerVolume" = {
              spawn = [
                "dms"
                "ipc"
                "audio"
                "decrement"
                "5"
              ];
              parameters.allow-when-locked = true;
            };

            "XF86AudioMute" = {
              spawn = [
                "dms"
                "ipc"
                "audio"
                "mute"
              ];
              parameters.allow-when-locked = true;
            };

            "XF86AudioMicMute" = {
              spawn = [
                "dms"
                "ipc"
                "audio"
                "micmute"
              ];
              parameters.allow-when-locked = true;
            };

            "XF86MonBrightnessUp" = {
              spawn = [
                "dms"
                "ipc"
                "brightness"
                "increment"
                "5"
                ""
              ];
              parameters.allow-when-locked = true;
            };

            "XF86MonBrightnessDown" = {
              spawn = [
                "dms"
                "ipc"
                "brightness"
                "decrement"
                "5"
                ""
              ];
              parameters.allow-when-locked = true;
            };

            "XF86AudioPrev" = {
              spawn = [
                "dms"
                "ipc"
                "mpris"
                "previous"
              ];
              parameters.allow-when-locked = true;
            };

            "XF86AudioNext" = {
              spawn = [
                "dms"
                "ipc"
                "mpris"
                "next"
              ];
              parameters.allow-when-locked = true;
            };

            "XF86AudioPlay" = {
              spawn = [
                "dms"
                "ipc"
                "mpris"
                "playPause"
              ];
              parameters.allow-when-locked = true;
            };

            "Mod+O" = {
              action = "toggle-overview";
              parameters.repeat = false;
            };

            "Mod+Q" = {
              action = "close-window";
              parameters.repeat = false;
            };

            "Mod+H".action = "focus-column-left";
            "Mod+J".action = "focus-window-or-workspace-down";
            "Mod+K".action = "focus-window-or-workspace-up";
            "Mod+L".action = "focus-column-right";

            "Mod+Ctrl+H".action = "move-column-left";
            "Mod+Ctrl+J".action = "move-window-down-or-to-workspace-down";
            "Mod+Ctrl+K".action = "move-window-up-or-to-workspace-up";
            "Mod+Ctrl+L".action = "move-column-right";

            "Mod+Home".action = "focus-column-first";
            "Mod+End".action = "focus-column-last";
            "Mod+Ctrl+Home".action = "move-column-to-first";
            "Mod+Ctrl+End".action = "move-column-to-last";

            "Mod+Shift+H".action = "focus-monitor-left";
            "Mod+Shift+J".action = "focus-monitor-down";
            "Mod+Shift+K".action = "focus-monitor-up";
            "Mod+Shift+L".action = "focus-monitor-right";

            "Mod+Shift+Ctrl+H".action = "move-column-to-monitor-left";
            "Mod+Shift+Ctrl+U".action = "move-column-to-monitor-down";
            "Mod+Shift+Ctrl+I".action = "move-column-to-monitor-up";
            "Mod+Shift+Ctrl+L".action = "move-column-to-monitor-right";

            "Mod+WheelScrollDown" = {
              action = "focus-workspace-down";
              parameters.cooldown-ms = 150;
            };
            "Mod+WheelScrollUp" = {
              action = "focus-workspace-up";
              parameters.cooldown-ms = 150;
            };
            "Mod+Ctrl+WheelScrollDown" = {
              action = "move-column-to-workspace-down";
              parameters.cooldown-ms = 150;
            };
            "Mod+Ctrl+WheelScrollUp" = {
              action = "move-column-to-workspace-up";
              parameters.cooldown-ms = 150;
            };

            "Mod+WheelScrollRight".action = "focus-column-right";
            "Mod+WheelScrollLeft".action = "focus-column-left";
            "Mod+Ctrl+WheelScrollRight".action = "move-column-right";
            "Mod+Ctrl+WheelScrollLeft".action = "move-column-left";

            "Mod+Shift+WheelScrollDown".action = "focus-column-right";
            "Mod+Shift+WheelScrollUp".action = "focus-column-left";
            "Mod+Ctrl+Shift+WheelScrollDown".action = "move-column-right";
            "Mod+Ctrl+Shift+WheelScrollUp".action = "move-column-left";

            "Mod+1".action = "focus-workspace 1";
            "Mod+2".action = "focus-workspace 2";
            "Mod+3".action = "focus-workspace 3";
            "Mod+4".action = "focus-workspace 4";
            "Mod+5".action = "focus-workspace 5";
            "Mod+6".action = "focus-workspace 6";
            "Mod+7".action = "focus-workspace 7";
            "Mod+8".action = "focus-workspace 8";
            "Mod+9".action = "focus-workspace 9";
            "Mod+Ctrl+1".action = "move-column-to-workspace 1";
            "Mod+Ctrl+2".action = "move-column-to-workspace 2";
            "Mod+Ctrl+3".action = "move-column-to-workspace 3";
            "Mod+Ctrl+4".action = "move-column-to-workspace 4";
            "Mod+Ctrl+5".action = "move-column-to-workspace 5";
            "Mod+Ctrl+6".action = "move-column-to-workspace 6";
            "Mod+Ctrl+7".action = "move-column-to-workspace 7";
            "Mod+Ctrl+8".action = "move-column-to-workspace 8";
            "Mod+Ctrl+9".action = "move-column-to-workspace 9";

            "Mod+Comma".action = "consume-window-into-column";
            "Mod+Period".action = "expel-window-from-column";

            "Mod+BracketLeft".action = "consume-or-expel-window-left";
            "Mod+BracketRight".action = "consume-or-expel-window-right";

            "Mod+R".action = "switch-preset-column-width";
            "Mod+Shift+R".action = "switch-preset-window-height";
            "Mod+Ctrl+R".action = "reset-window-height";
            "Mod+F".action = "maximize-column";
            "Mod+Shift+F".action = "fullscreen-window";
            "Mod+Ctrl+F".action = "expand-column-to-available-width";
            "Mod+C".action = "center-column";

            "Mod+Minus".action = "set-column-width \"-10%\"";
            "Mod+Equal".action = "set-column-width \"+10%\"";

            "Mod+Shift+Minus".action = "set-window-height \"-10%\"";
            "Mod+Shift+Equal".action = "set-window-height \"+10%\"";

            "Mod+V".action = "switch-focus-between-floating-and-tiling";
            "Mod+Shift+V".action = "toggle-window-floating";

            "Mod+W".action = "toggle-column-tabbed-display";

            "Print".action = "screenshot-screen";
            "Shift+Print".action = "screenshot";
            "Ctrl+Print".action = "screenshot-window";

            "Mod+Insert".action = "set-dynamic-cast-window";
            "Mod+Shift+Insert".action = "set-dynamic-cast-monitor";
            "Mod+Delete".action = "clear-dynamic-cast-target";

            "Mod+Escape" = {
              action = "toggle-keyboard-shortcuts-inhibit";
              parameters.allow-inhibiting = false;
            };

            "Mod+Shift+P".action = "power-off-monitors";
          };
        };
      };
  };
}
