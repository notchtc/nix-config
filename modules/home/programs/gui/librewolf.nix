{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.mama;

  inherit (builtins) toJSON;
  inherit (lib) mkForce mkIf optionals;

  gaming = cfg.profiles.gaming.enable;
  graphical = cfg.profiles.graphical.enable;
in
{
  config = mkIf graphical {
    programs.librewolf = {
      enable = true;
      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];

      configPath = "${config.xdg.configHome}/librewolf/librewolf";

      policies = {
        ExtensionSettings =
          map
            (id: {
              ${id} = {
                installation_mode = "force_installed";
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/${lib.strings.escapeURL id}/latest.xpi";
              };
            })
            [
              "plasma-browser-integration@kde.org"
              "sponsorBlocker@ajay.app"
              "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" # Refined GitHub
              "V3-eov3cv@hotmail.com"
              "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" # Violentmonkey
            ]
          ++ optionals gaming [
            "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}" # Augmented Steam
          ];

        "3rdparty".Extensions."uBlock0@raymondhill.net".adminSettings = toJSON {
          userSettings.advancedUserEnabled = true;

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
            "adguard-cookies"
            "ublock-cookies-adguard"
            "fanboy-social"
            "adguard-social"
            "fanboy-thirdparty_social"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "adguard-mobile-app-banners"
            "adguard-other-annoyances"
            "adguard-popup-overlays"
            "adguard-widgets"
            "ublock-annoyances"
            "POL-3"
            "POL-0"
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

      profiles.default = {
        settings = {
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

        search = {
          default = "ddg";
          force = true;

          engines = {
            bing.metaData.hidden = true;
            google.metaData.hidden = true;
            perplexity.metaData.hidden = true;

            nixpkgs = {
              name = "Nixpkgs query";
              definedAliases = [ "!nix" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            home-manager = {
              name = "Home-Manager query";
              definedAliases = [ "!hm" ];
              icon = "https://home-manager-options.extranix.com/images/favicon.png";

              urls = [
                {
                  template = "https://home-manager-options.extranix.com";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "release";
                      value = "master";
                    }
                  ];
                }
              ];
            };
          };
        };
      };
    };

    home.file = {
      ".librewolf/native-messaging-hosts".enable = mkForce false;
      ".mozilla/native-messaging-hosts".enable = mkForce false;
    };

    stylix.targets.librewolf.profileNames = [ "default" ];
  };
}
