{ inputs, config, ... }:
{
  imports = [ inputs.schizofox.result.homeManagerModules.default ];

  home.sessionVariables.BROWSER = "schizofox";

  programs.schizofox = {
    enable = true;

    search.defaultSearchEngine = "DuckDuckGo";
    settings = {
      "dom.event.clipboardevents.enabled" = true;
      "privacy.resistFingerprinting.letterboxing" = false;

      "toolkit.tabbox.switchByScrolling" = true;

      "layers.acceleration.force-enabled" = true;
      "media.ffmpeg.vaapi.enabled" = true;
    };

    extensions = {
      enableDefaultExtensions = false;
      enableExtraExtensions = true;
      extraExtensions = {
        "{9a41dee2-b924-4161-a971-7fb35c053a4a}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/enhanced-h264ify/latest.xpi";
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
        "7esoorv3@alefvanoon.anonaddy.me".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/libredirect/latest.xpi";
        "skipredirect@sblask".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
        "sponsorBlocker@ajay.app".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        "uBlock0@raymondhill.net".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      };
      darkreader.enable = false;
      simplefox.enable = false;
    };

    misc = {
      contextMenu.enable = true;
      disableWebgl = false;
      displayBookmarksInToolbar = "newtab";
      drm.enable = true;
      firefoxSync = false;
      customMozillaFolder = {
        enable = true;
        path = "/.local/share/mozilla";
      };
    };

    theme = {
      font = config.stylix.fonts.sansSerif;

      defaultUserChrome.enable = false;
      defaultUserContent.enable = false;

      extraUserChrome = ''
        #webrtcIndicator {
          display: none;
        }
        .tab-label-container {
          mask-image: none !important;
        }
        .titlebar-spacer[type="pre-tabs"] {
         display: none !important;
        }
        .tabbrowser-tab .tab-close-button {
          visibility: collapse !important;
        }
      '';
    };
  };
}
