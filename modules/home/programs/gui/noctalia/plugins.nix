{ lib, profiles, ... }:
{
  programs.noctalia-shell = lib.mkIf profiles.graphical.enable {
    settings.plugins.autoUpdate = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];

      states = {
        kaomoji-provider = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        polkit-agent = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };

    pluginSettings = {
      privacy-indicator = {
        hideInactive = true;
        iconSpacing = 4;
        removeMargins = false;
        activeColor = "primary";
        inactiveColor = "none";
      };
    };
  };
}
