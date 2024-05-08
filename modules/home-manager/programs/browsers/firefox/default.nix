{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];

    profiles = {
      Default = {
        extensions = lib.attrValues {
          inherit (config.nur.repos.rycee.firefox-addons)
            enhanced-h264ify
            multi-account-containers
            plasma-integration
            ublock-origin
            skip-redirect
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

          .tabbrowser-tab .tab-close-button {
            visibility: collapse !important;
          }
        '';

        extraConfig = builtins.readFile ./user.js;
      };
    };
  };
}
