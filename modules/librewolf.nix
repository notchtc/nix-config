{
  config.modules = {
    nixos.librewolf =
      { lib, pkgs, ... }:
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

          nativeMessagingHosts.packages = [ pkgs.keepassxc ];

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
                    "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}" # Augmented Steam
                    "keepassxc-browser@keepassxc.org"
                    "nixpkgs-pr-tracker@tahayassine.me"
                    "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" # Refined GitHub
                    "sponsorBlocker@ajay.app"
                    "V3-eov3cv@hotmail.com"
                    "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" # Violentmonkey
                  ];

            "3rdparty".Extensions."uBlock0@raymondhill.net".adminSettings = toJSON {
              userSettings = {
                advancedUserEnabled = true;
                userFiltersTrusted = true;
              };

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
                * awswaf.com * noop
                * cdnjs.cloudflare.com * noop
                * challenges.cloudflare.com * noop
                * cloudfront.net * noop
                * discourse-cdn.com * noop
                * disqus.com * noop
                * c.disquscdn.com * noop
                * static-2v.gitbook.com * noop
                * googleusercontent.com * noop
                * gstatic.com * noop
                * hcaptcha.com * noop
                * js.hcaptcha.com * noop
                * code.jquery.com * noop
                * cdn.jsdelivr.net * noop
                * umap.openstreetmap.fr * noop
                * recaptcha.net * noop
                * cdn.shopify.com * noop
                * checkout.pci.shopifyinc.com * noop
                * stripe.com * noop
                * unpkg.com * noop
                * www.youtube-nocookie.com * noop
                allegro.pl assets.allegrostatic.com * noop
                allegro.pl captcha-delivery.com * noop
                allegrolokalnie.pl lokalnie-prod-assets.storage.googleapis.com * noop
                www.amazon.com m.media-amazon.com * noop
                bandcamp.com s4.bcbits.com * noop
                bandcamp.com dualstack.n.sni.global.fastly.net * noop
                bsky.app bsky-web.b-cdn.net * noop
                codepen.io cdpn.io * noop
                www.discogs.com catalog-assets.discogs.com.cdn.cloudflare.net * noop
                www.discogs.com footer.discogs.com.cdn.cloudflare.net * noop
                www.discogs.com st.discogs.com.cdn.cloudflare.net * noop
                dropbox.com cfl.dropboxstatic.com * noop
                dropbox.com dropboxusercontent.com * noop
                www.facebook.com static.xx.fbcdn.net * noop
                genius.com medialab.map.fastly.net * noop
                github.com github.githubassets.com * noop
                imgur.com ipv4.imgur.map.fastly.net * noop
                www.instagram.com static.cdninstagram.com * noop
                forum.jrockone.com jrockone.b-cdn.net * noop
                www.last.fm jsdelivr.map.fastly.net * noop
                www.last.fm cdn.jsdelivr.net.cdn.cloudflare.net * noop
                letterboxd.com s.ltrbxd.com * noop
                rateyourmusic.com cdn.sonemic.net * noop
                www.reddit.com dualstack.reddit.map.fastly.net * noop
                www.reddit.com www.redditstatic.com * noop
                rutracker.org static.rutracker.cc * noop
                rutracker.org rutrk.org * noop
                sourceforge.net a.fsdn.com.cdn.cloudflare.net * noop
                sourceforge.net a.fsdn.com * noop
                accounts.spotify.com accounts.scdn.co * noop
                challenge.spotify.com challenge.spotifycdn.com * noop
                open.spotify.com open.spotifycdn.com * noop
                open.spotify.com tls130rtt.spotifycdn.map.fastly.net * noop
                store.steampowered.com store.akamai.steamstatic.com * noop
                x.com abs.twimg.com.cdn.cloudflare.net * noop
                x.com abs.twimg.com * noop
                x.com twimg.twitter.map.fastly.net * noop
                www.youtube.com google.com * noop
              '';

              userFilters = ''
                facebook.com##+js(trusted-click-element, body > div[id^="mount"] #scrollview ~ div div[role="button"]:has(> div[data-visualcompletion="ignore"]) )
                facebook.com##div[id^="mount"] div:not([id]):not([class]):not([style]) > div[data-nosnippet]
                facebook.com##+js(aeld, scroll)
                facebook.com##body > div[class*="__fb-light-mode"]

                ||tumblr.com/*/async-login-wall$script,1p
              '';
            };

            Permissions.Notifications.BlockNewRequests = true;
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
            "general.smoothScroll" = true;
            "middlemouse.paste" = false;
            "sidebar.main.tools" = "history,bookmarks";
            "sidebar.verticalTabs" = true;
            "sidebar.visibility" = "expand-on-hover";
            "toolkit.tabbox.switchByScrolling" = true;

            "gfx.webrender.all" = true;
            "layers.acceleration.force-enabled" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "media.hardware-video-decoding.force-enabled" = true;

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
