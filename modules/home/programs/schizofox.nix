{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.mama.desktops;
in
{
  imports = [ inputs.schizofox.result.homeManagerModules.default ];

  programs.schizofox = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;

    search.defaultSearchEngine = "DuckDuckGo";
    settings = {
      "dom.event.clipboardevents.enabled" = true;
      "privacy.resistFingerprinting" = false;
      "privacy.resistFingerprinting.letterboxing" = false;

      "middlemouse.paste" = false;
      "toolkit.tabbox.switchByScrolling" = true;

      "media.ffmpeg.vaapi.enabled" = true;
      "layers.acceleration.force-enabled" = true;
      "svg.context-properties.content.enabled" = true;
    }
    // lib.optionalAttrs cfg.gnome.enable {
      "gnomeTheme.bookmarksToolbarUnderTabs" = true;
      "gnomeTheme.hideWebrtcIndicator" = true;
      "gnomeTheme.normalWidthTabs" = true;
    };

    extensions = {
      enableDefaultExtensions = false;
      enableExtraExtensions = true;
      extraExtensions = {
        "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/augmented-steam/latest.xpi";
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
        "7esoorv3@alefvanoon.anonaddy.me".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/libredirect/latest.xpi";
        "sponsorBlocker@ajay.app".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        "uBlock0@raymondhill.net".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        "V3-eov3cv@hotmail.com".install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/v3-get-old-youtube-layout/latest.xpi";
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
      defaultUserChrome.enable = false;
      defaultUserContent.enable = false;

      extraUserChrome =
        if cfg.gnome.enable then
          ''
            @import "${inputs.firefox-gnome-theme.result}/userChrome.css"
          ''
        else
          ''
            #webrtcIndicator { display: none; }
            .tab-label-container { mask-image: none !important; }
            .titlebar-spacer[type="pre-tabs"] { display: none !important; }
            .tabbrowser-tab .tab-close-button { visibility: collapse !important; }
          '';
    };
  };
}
