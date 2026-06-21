{
  config.modules = {
    nixos.dms = { inputs, modules, ... }: {
      imports = [ inputs.dms-plugin-registry.result.nixosModules.default ];

      programs.dms-shell = {
        enable = true;

        enableAudioWavelength = false;
        enableCalendarEvents = false;
        enableClipboardPaste = false;
        enableDynamicTheming = false;
        enableSystemMonitoring = false;
        enableVPN = false;

        plugins = {
          dankBatteryAlerts.enable = true;
          niriWindows.enable = true;
          nixPackageRunner.enable = true;
          emojiLauncher.enable = true;
        };
      };

      hjem.extraModules = [ modules.home.dms ];
    };

    home.dms =
      { lib, ... }:
      let
        inherit (lib.generators) toJSON;
      in
      {
        xdg.config.files = {
          "DankMaterialShell/settings.json".source = ./settings.json;
          "DankMaterialShell/plugin_settings.json" = {
            generator = toJSON { };
            value = {
              dankBatteryAlerts.enabled = true;
              emojiLauncher = {
                enabled = true;
                trigger = "em";
              };
              nixPackageRunner.enabled = true;
              niriWindows.enabled = true;
            };
          };
        };

        xdg.state.files."DankMaterialShell/session.json" = {
          generator = toJSON { };
          value = {
            configVersion = 1;
            doNotDisturb = false;
            isLightMode = false;
            nightModeAutoEnabled = true;
            nightModeAutoMode = "location";
            nightModeEnabled = true;
            nightModeUseIPLocation = true;
            showThirdPartyPlugins = true;
            wallpaperPath = ./wallpaper.jpg;
          };
        };
      };
  };
}
