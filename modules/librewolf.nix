{
  config.modules = {
    nixos.librewolf =
      {
        lib,
        modules,
        pkgs,
        ...
      }:
      let
        inherit (builtins) listToAttrs toJSON;
        inherit (lib.attrsets) nameValuePair;
        inherit (lib.strings) escapeURL;
      in
      {
        environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";

        programs.firefox = {
          enable = true;
          package = pkgs.librewolf;

          policies = {
            ExtensionSettings =
              listToAttrs
              <|
                map
                  (
                    id:
                    nameValuePair id {
                      installation_mode = "force_installed";
                      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${escapeURL id}/latest.xpi";
                    }
                  )

                  [
                    "sponsorBlocker@ajay.app"
                    "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" # Refined GitHub
                    "V3-eov3cv@hotmail.com"
                    "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" # Violentmonkey
                    "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}" # Augmented Steam
                  ];

            "3rdparty".Extensions."uBlock0@raymondhill.net".adminSettings = toJSON {
              userSettings.advancedUserEnabled = true;

              selectedFilterLists = [
                "adguard-cookies"
                "adguard-mobile-app-banners"
                "adguard-other-annoyances"
                "adguard-popup-overlays"
                "adguard-social"
                "adguard-spyware-url"
                "adguard-widgets"
                "curben-phishing"
                "easylist"
                "easylist-annoyances"
                "easylist-chat"
                "easylist-newsletters"
                "easylist-notifications"
                "easyprivacy"
                "fanboy-ai-suggestions"
                "fanboy-cookiemonster"
                "fanboy-social"
                "fanboy-thirdparty_social"
                "LegitimateURLShortener"
                "plowe-0"
                "POL-0"
                "POL-3"
                "ublock-annoyances"
                "ublock-badware"
                "ublock-cookies-adguard"
                "ublock-cookies-easylist"
                "ublock-filters"
                "ublock-privacy"
                "ublock-quick-fixes"
                "ublock-unbreak"
                "urlhaus-1"
                "user-filters"
              ];

              dynamicFilteringString = ''
                no-csp-reports: * true
                * * 3p-frame block
                * * 3p-script block
                * ajax.googleapis.com * noop
                * cdnjs.cloudflare.com * noop
                * challenges.cloudflare.com * noop
                * discourse-cdn.com * noop
                * googleusercontent.com * noop
                * gstatic.com * noop
                * hcaptcha.com * noop
                * js.hcaptcha.com * noop
                * code.jquery.com * noop
                * jsdelivr.map.fastly.net * noop
                * cdn.jsdelivr.net * noop
                * recaptcha.net * noop
                * unpkg.com * noop
                aliexpress.com alicdn.com * noop
                aliexpress.com assets.aliexpress-media.com * noop
                pl.aliexpress.com alicdn.com * noop
                pl.aliexpress.com assets.aliexpress-media.com * noop
                allegro.pl assets.allegrostatic.com * noop
                allegro.pl captcha-delivery.com * noop
                allegrolokalnie.pl lokalnie-prod-assets.storage.googleapis.com * noop
                www.allmusic.com t.sni.global.fastly.net * noop
                bandcamp.com bcbits.com * noop
                bandcamp.com dualstack.n.sni.global.fastly.net * noop
                bandcamp.com core.spreedly.com * noop
                www.discogs.com catalog-assets.discogs.com.cdn.cloudflare.net * noop
                www.discogs.com st.discogs.com.cdn.cloudflare.net * noop
                dropbox.com cfl.dropboxstatic.com * noop
                dropbox.com dropboxusercontent.com * noop
                home-manager-options.extranix.com maxcdn.bootstrapcdn.com * noop
                facebook.com meta-api.arkoselabs.com * noop
                facebook.com static.xx.fbcdn.net * noop
                facebook.com www.fbsbx.com * noop
                github.com github.githubassets.com * noop
                www.instagram.com static.cdninstagram.com * noop
                forum.jrockone.com jrockone.b-cdn.net * noop
                www.last.fm cdn.jsdelivr.net.cdn.cloudflare.net * noop
                www.last.fm js-agent.newrelic.com * noop
                rateyourmusic.com e.snmc.io * noop
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

                ||tumblr.com/*/async-login-wall$script,1p

                quillbot.com##.css-ekeie0.MuiDialog-scrollPaper.MuiDialog-container
                quillbot.com##.css-919eu4.MuiBackdrop-root
                quillbot.com##.css-yslrk6.MuiDialog-root.MuiModal-root
              '';
            };
          };

          preferences = {
            "privacy.fingerprintingProtection" = true;
            "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC";
            "privacy.resistFingerprinting" = false;
            "privacy.sanitize.sanitizeOnShutdown" = false;
            "webgl.disabled" = false;

            "browser.tabs.groups.enabled" = false;
            "browser.tabs.inTitlebar" = 0;
            "browser.toolbars.bookmarks.visibility" = "never";
            "findbar.highlightAll" = true;
            "general.autoScroll" = true;
            "middlemouse.paste" = false;
            "sidebar.main.tools" = "history,bookmarks";
            "sidebar.verticalTabs" = true;
            "sidebar.visibility" = "expand-on-hover";
            "toolkit.tabbox.switchByScrolling" = true;
            "ui.prefersReducedMotion" = 1;

            "gfx.webrender.all" = true;
            "layers.acceleration.force-enabled" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "media.hardware-video-decoding.force-enabled" = true;
            "svg.context-properties.content.enabled" = true;

            "browser.uiCustomization.state" = toJSON {
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
          };
        };

        hjem.extraModules = [ modules.home.librewolf ];
      };

    home.librewolf =
      { lib, ... }:
      let
        inherit (lib.attrsets) genAttrs;
        inherit (lib.trivial) const flip;
      in
      {
        xdg.mime-apps.default-applications = flip genAttrs (const "librewolf.desktop") [
          "application/json"
          "application/pdf"
          "application/x-extension-htm"
          "application/x-extension-html"
          "application/x-extension-shtml"
          "application/x-extension-xht"
          "application/x-extension-xhtml"
          "application/xhtml+xml"
          "text/html"
          "x-scheme-handler/about"
          "x-scheme-handler/ftp"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/unknown"
          "x-www-browser"
        ];
      };
  };
}
