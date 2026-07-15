{
  config.modules.home.noctalia = { config, ... }: {
    programs.noctalia = {
      enable = true;

      settings = {
        bar.default = {
          start = [
            "clock"
            "privacy"
          ];
          center = [ ];
          end = [
            "media"
            "tray"
            "notifications"
            "clipboard"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "spacer"
            "control-center"
          ];

          auto_hide = true;
          margin_edge = 0;
          margin_ends = 0;
          position = "left";
          radius = 0;
          reserve_space = false;
          show_on_workspace_switch = false;
          thickness = 40;
          widget_spacing = 12;
        };

        idle = {
          behavior_order = [
            "lock"
            "screen-off"
            "lock-and-suspend"
          ];

          behavior = {
            lock = {
              action = "lock";
              enabled = true;
              timeout = 600.0;
            };

            lock-and-suspend = {
              action = "lock_and_suspend";
              enabled = true;
              timeout = 900.0;
            };

            screen-off = {
              action = "screen_off";
              enabled = true;
              timeout = 660.0;
            };
          };
        };

        osd = {
          offset_x = 8;
          offset_y = 4;
          orientation = "vertical";
          position = "top_right";
          position_vertical = "top_right";
        };

        shell = {
          corner_radius_scale = 0.8;
          polkit_agent = true;

          panel = {
            control_center_placement = "floating";
            open_near_click_control_center = true;
          };
        };

        theme = {
          community_palette = "Breeze";
          mode = "dark";
          source = "community";
        };

        widget = {
          bluetooth.hide_when_no_connected_device = true;
          brightness.show_label = false;
          control-center.custom_image = "${config.programs.noctalia.package}/share/noctalia/assets/images/distros/nixos.svg";
          media.hide_when_no_media = true;
          network.show_label = false;
          notifications.hide_when_no_unread = true;
          privacy.hide_inactive = true;
          spacer.type = "spacer";
          volume.show_label = true;
        };

        location.auto_locate = true;
        nightlight.enabled = true;
        wallpaper.default.path = ./wallpaper.jpg;
      };
    };
  };
}
