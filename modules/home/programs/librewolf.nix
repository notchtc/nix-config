{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf optionalAttrs;
  inherit (config.mama) desktop;
  graphical = config.mama.profiles.graphical.enable;
in
{
  programs.librewolf = mkIf graphical {
    enable = true;
    nativeMessagingHosts = mkIf (desktop == "plasma") [ pkgs.kdePackages.plasma-browser-integration ];

    policies = {
      PasswordManagerEnabled = false;
      ExtensionSettings =
        let
          install = id: {
            ${id} = {
              installation_mode = "force_installed";
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${lib.strings.escapeURL id}/latest.xpi";
            };
          };
        in
        {
          "uBlock0@raymondhill.net".installation_mode = "blocked";
        }
        // install "adnauseam@rednoise.org"
        // install "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}" # Augmented Steam
        // install "plasma-browser-integration@kde.org"
        // install "sponsorBlocker@ajay.app"
        // install "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" # Refined GitHub
        // install "V3-eov3cv@hotmail.com"
        // install "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}"; # Violentmonkey

      "3rdparty".Extensions."adnauseam@rednoise.org".adminSettings = builtins.toJSON {
        userSettings = {
          firstInstall = false;
          hidingAds = true;
          clickingAds = true;
          blockingMalware = true;

          importedLists = [
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/LegitimateURLShortener.txt"
          ];
        };

        selectedFilterLists = [
          "user-filters"
          "adnauseam-filters"
          "eff-dnt-whitelist"
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "easylist"
          "easyprivacy"
          "adguard-spyware-url"
          "urlhaus-1"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/LegitimateURLShortener.txt"
        ];
      };
    };

    profiles.default = {
      settings = {
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "privacy.resistFingerprinting" = false;
        "webgl.disabled" = false;

        "browser.toolbars.bookmarks.visibility" = "newbar";
        "general.autoScroll" = true;
        "middlemouse.paste" = false;
        "findbar.highlightAll" = true;
        "sidebar.main.tools" = "history,bookmarks";
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "expand-on-hover";
        "toolkit.tabbox.switchByScrolling" = true;

        "media.ffmpeg.vaapi.enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "svg.context-properties.content.enabled" = true;

        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            nav-bar = [
              "sidebar-button"
              "back-button"
              "forward-button"
              "stop-reload-button"
              "vertical-spacer"
              "urlbar-container"
              "downloads-button"
              "unified-extensions-button"
              "sponsorblocker_ajay_app-browser-action"
              "adnauseam_rednoise_org-browser-action"
            ];
          };
          currentVersion = 23;
        };
      }
      // optionalAttrs (desktop == "gnome") {
        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.hideWebrtcIndicator" = true;
        "gnomeTheme.normalWidthTabs" = true;
      }
      // optionalAttrs (desktop == "plasma") { "browser.tabs.inTitlebar" = 0; };

      userChrome = mkIf (desktop == "gnome") ''
        @import "${inputs.firefox-gnome-theme.result}/userChrome.css"
      '';
    };
  };
}
