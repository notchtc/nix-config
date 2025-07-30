{ inputs, ... }:
{
  imports = [ inputs.schizofox.result.homeManagerModules.default ];

  home.sessionVariables = {
    BROWSER = "schizofox";
  };

  programs.schizofox = {
    enable = true;

    security.sandbox.enable = true;

    settings = {
      "dom.event.clipboardevents.enabled" = true;
      "privacy.resistFingerprinting.letterboxing" = false;

      "toolkit.tabbox.switchByScrolling" = true;

      "layers.acceleration.force-enabled" = true;
      "media.ffmpeg.vaapi.enabled" = true;
    };

    theme = {
      font = "Inter";

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

    search = {
      defaultSearchEngine = "DuckDuckGo";
    };

    extensions = {
      enableDefaultExtensions = true;
      enableExtraExtensions = true;
      extraExtensions = {
        "{9a41dee2-b924-4161-a971-7fb35c053a4a}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/enhanced-h264ify/latest.xpi";
        "{cb31ec5d-c49a-4e5a-b240-16c767444f62}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/indie-wiki-buddy/latest.xpi";
        "skipredirect@sblask".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
        "sponsorBlocker@ajay.app".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
      };

      darkreader.enable = false;
      simplefox.enable = false;
    };

    misc = {
      contextMenu.enable = true;
      customMozillaFolder.path = "/.local/share/schizofox/mozilla";
      disableWebgl = false;
      displayBookmarksInToolbar = "newtab";
      drm.enable = true;
      firefoxSync = false;
    };
  };
}
