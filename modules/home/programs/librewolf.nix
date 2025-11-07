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
      ExtensionSettings =
        let
          install = id: {
            ${id} = {
              installation_mode = "force_installed";
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${lib.strings.escapeURL id}/latest.xpi";
            };
          };
        in
        install "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}" # Augmented Steam
        // install "plasma-browser-integration@kde.org"
        // install "sponsorBlocker@ajay.app"
        // install "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" # Refined GitHub
        // install "V3-eov3cv@hotmail.com"
        // install "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}"; # Violentmonkey

      "3rdparty".Extensions."uBlock0@raymondhill.net".adminSettings = builtins.toJSON {
        userSettings = {
          advancedUserEnabled = true;
        };

        selectedFilterLists = [
          "user-filters"
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "easylist"
          "easyprivacy"
          "LegitimateURLShortener"
          "adguard-spyware-url"
          "urlhaus-1"
          "curben-phishing"
          "plowe-0"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "easylist-chat"
          "easylist-newsletters"
          "easylist-notifications"
          "easylist-annoyances"
          "POL-3"
          "POL-0"
        ];

        dynamicFilteringString = ''
          no-csp-reports: * true
          * * 3p-frame block
          * * 3p-script block
          * cdnjs.cloudflare.com * noop
          * challenges.cloudflare.com * noop
          * discourse-cdn.com * noop
          bandcamp.com bcbits.com * noop
          bandcamp.com core.spreedly.com * noop
          facebook.com meta-api.arkoselabs.com * noop
          facebook.com static.xx.fbcdn.net * noop
          facebook.com www.fbsbx.com * noop
          github.com github.githubassets.com * noop
          forum.jrockone.com jrockone.b-cdn.net * noop
          www.reddit.com dualstack.reddit.map.fastly.net * noop
          www.reddit.com www.redditstatic.com * noop
          accounts.spotify.com accounts.scdn.co * noop
          challenge.spotify.com challenge.spotifycdn.com * noop
          open.spotify.com spotifycdn.com * noop
          open.spotify.com spotifycdn.map.fastly.net * noop
          steamcommunity.com community.fastly.steamstatic.com * noop
          store.steampowered.com store.fastly.steamstatic.com * noop
          x.com abs.twimg.com * noop
          x.com twimg.twitter.map.fastly.net * noop
        '';

        userFilters = ''
          facebook.com##+js(trusted-click-element, body > div[id^="mount"] #scrollview ~ div div[role="button"]:has(> div[data-visualcompletion="ignore"]) )
          facebook.com##div[id^="mount"] div:not([id]):not([class]):not([style]) > div[data-nosnippet]
          facebook.com##+js(aeld, scroll)
          facebook.com##body > div[class*="__fb-light-mode"]  
        '';
      };
    };

    profiles.default = {
      settings = {
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC";
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "privacy.resistFingerprinting" = false;
        "webgl.disabled" = false;

        "browser.toolbars.bookmarks.visibility" = "never";
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
              "ublock0_raymondhill_net-browser-action"
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
