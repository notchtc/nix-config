{ config, lib, ... }:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
in
{
  programs.vesktop = mkIf graphical {
    enable = true;

    settings = {
      discordBranch = "canary";
      hardwareAcceleration = true;
    };
    vencord.settings.plugins = {
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
}
