{
  config.modules.home = {
    discord =
      { lib, pkgs, ... }:
      let
        inherit (lib.attrsets) genAttrs;
        inherit (lib.generators) toJSON;
        inherit (lib.trivial) const flip;
      in
      {
        packages = [ pkgs.vesktop ];

        xdg = {
          config.files = {
            "vesktop/settings.json" = {
              generator = toJSON { };
              value = {
                arRPC = true;
                discordBranch = "canary";
                hardwareAcceleration = true;
              };
            };

            "vesktop/settings/settings.json" = {
              generator = toJSON { };
              value = {
                plugins = {
                  BetterGifAltText.enabled = true;
                  BetterRoleContext.enabled = true;
                  BetterRoleDot.enabled = true;
                  BetterSessions.enabled = true;
                  BetterSettings.enabled = true;
                  BetterUploadButton.enabled = true;
                  ClearURLs.enabled = true;
                  CopyUserURLs.enabled = true;
                  FakeNitro.enabled = true;
                  FavoriteGifSearch.enabled = true;
                  FixSpotifyEmbeds.enabled = true;
                  FixYoutubeEmbeds.enabled = true;
                  ForceOwnerCrown.enabled = true;
                  ImageZoom.enabled = true;
                  MessageLogger.enabled = true;
                  PermissionsViewer.enabled = true;
                  PlatformIndicators.enabled = true;
                  RelationshipNotifier.enabled = true;
                  ShowHiddenChannels.enabled = true;
                  ShowHiddenThings.enabled = true;
                  SpotifyCrack.enabled = true;
                  YoutubeAdblock.enabled = true;
                };
              };
            };
          };

          mime-apps =
            let
              defaults = flip genAttrs (const "vesktop.desktop") [ "x-scheme-handler/discord" ];
            in
            {
              added-associations = defaults;
              default-applications = defaults;
            };
        };
      };

    telegram =
      { lib, pkgs, ... }:
      let
        inherit (lib.attrsets) genAttrs;
        inherit (lib.trivial) const flip;
      in
      {
        packages = [ (pkgs.telegram-desktop.override { withWebkit = false; }) ];

        xdg.mime-apps =
          let
            defaults = flip genAttrs (const "org.telegram.desktop.desktop") [ "x-scheme-handler/tg" ];
          in
          {
            added-associations = defaults;
            default-applications = defaults;
          };
      };
  };
}
