{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;

    package = pkgs.firefox;

    profiles = {
      Default = {
        extensions = lib.attrValues {
          inherit
            (config.nur.repos.rycee.firefox-addons)
            ublock-origin
            skip-redirect
            enhanced-h264ify
            multi-account-containers
            sponsorblock
            ;
        };

        id = 0;

        search = {
          default = "DuckDuckGo";
          force = true;
        };

        userChrome = ''
          #webrtcIndicator {
            display: none;
          }

          .tab-label-container {
            mask-image: none !important;
          }

          .titlebar-spacer[type="pre-tabs"] {
           display: none !important;
          }
        '';

        extraConfig = builtins.readFile ./user.js;
      };
    };
  };
}
