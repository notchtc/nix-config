{ inputs, ... }:
{
  imports = [ inputs.schizofox.homeManagerModule ];

  home.sessionVariables = {
    BROWSER = "schizofox";
  };

  programs.schizofox = {
    enable = true;

    settings = {
      "dom.event.clipboardevents.enabled" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "privacy.resistFingerprinting.letterboxing" = false;
      "general.autoScroll" = true;
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
        "{c607c8df-14a7-4f28-894f-29e8722976af}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/temporary-containers/latest.xpi";
        "{9a41dee2-b924-4161-a971-7fb35c053a4a}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/enhanced-h264ify/latet.xpi";
        "@testpilot-containers".install_url =
          "https://addons.mozilla.org/firefox/download/latest/multi-account-containers/latest.xpi";
        "sponsorBlocker@ajay.app".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
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
    };
  };
}
