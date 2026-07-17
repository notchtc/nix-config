{
  config.modules.home.communicators =
    { lib, pkgs, ... }:
    let
      inherit (lib.attrsets) genAttrs;
      inherit (lib.generators) toJSON;
      inherit (lib.trivial) const flip;
    in
    {
      packages = [
        (pkgs.telegram-desktop.override { withWebkit = false; })
        ((pkgs.vesktop.override { electron_40 = pkgs.electron_41; }).overrideAttrs (prev: {
          preBuild = builtins.replaceStrings [ "exit 1" ] [ ":" ] (prev.preBuild or "");
        }))
      ];

      xdg = {
        config.files = {
          "vesktop/settings.json" = {
            generator = toJSON { };
            value = {
              arRPC = true;
              discordBranch = "canary";
              enableSplashScreen = false;
              hardwareAcceleration = true;

              spellCheckLanguagues = [
                "en-US"
                "pl"
              ];
            };
          };

          "vesktop/settings/settings.json" = {
            generator = toJSON { };
            value = {
              useQuickCss = false;

              themeLinks = [ "https://croissantdunord.github.io/discord-adblock/adblock.css" ];

              plugins = {
                BetterGifAltText.enabled = true;
                BetterRoleContext.enabled = true;
                BetterRoleDot.enabled = true;
                BetterSessions.enabled = true;
                BetterSettings.enabled = true;
                BetterUploadButton.enabled = true;
                ClearURLs.enabled = true;
                CopyUserURLs.enabled = true;
                CrashHandler.enabled = true;
                FakeNitro.enabled = true;
                FavoriteGifSearch.enabled = true;
                FixSpotifyEmbeds.enabled = true;
                FixYoutubeEmbeds.enabled = true;
                ForceOwnerCrown.enabled = true;
                ImageZoom.enabled = true;
                ImplicitRelationships.enabled = true;
                MessageLinkEmbeds.enabled = true;
                MessageLogger.enabled = true;
                NoMaskedUrlPaste.enabled = true;
                NoMiddleClickPaste.enabled = true;
                PermissionsViewer.enabled = true;
                PlatformIndicators.enabled = true;
                RelationshipNotifier.enabled = true;
                ShowHiddenChannels.enabled = true;
                ShowHiddenThings.enabled = true;
                SpotifyCrack.enabled = true;
                ValidReply.enabled = true;
                ValidUser.enabled = true;
                WebKeybinds.enabled = true;
                WebScreenShareFixes.enabled = true;
                YoutubeAdblock.enabled = true;
              };
            };
          };
        };

        mime-apps.default-applications =
          flip genAttrs (const "org.telegram.desktop.desktop") [ "x-scheme-handler/tg" ]
          // flip genAttrs (const "vesktop.desktop") [ "x-scheme-handler/discord" ];
      };
    };
}
