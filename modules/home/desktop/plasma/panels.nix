{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.self.packages.${pkgs.system}.split-clock ];

  programs.plasma.panels = [
    {
      location = "left";
      height = 28;
      floating = false;
      widgets = [
        {
          kickoff = {
            compactDisplayStyle = true;
            showActionButtonCaptions = false;
            sortAlphabetically = true;
            applicationsDisplayMode = "list";
            favoritesDisplayMode = "list";
            icon = "nix-snowflake-white";
            showButtonsFor = "session";
          };
        }
        {
          iconTasks = {
            launchers = [
              "applications:org.kde.dolphin.desktop"
              "applications:Schizofox.desktop"
              "applications:org.strawberrymusicplayer.strawberry.desktop"
              "applications:org.telegram.desktop.desktop"
              "applications:vesktop.desktop"
              "applications:steam.desktop"
            ];
          };
        }
        {
          systemTray = {
            icons = {
              spacing = "small";
              scaleToFit = true;
            };

            items = {
              hidden = [
                "org.kde.plasma.addons.katesessions"
                "org.kde.plasma.clipboard"
              ];
            };
          };
        }
        {
          name = "org.kde.plasma.pager";
          config = {
            General = {
              currentDesktopSelected = "ShowDesktop";
            };
          };
        }
        {
          name = "split-clock";
          config = {
            Appearance = {
              autoFontAndSize = true;
            };
          };
        }
      ];
    }
  ];
}
