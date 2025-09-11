{ config, lib, ... }:
{
  programs.vesktop = lib.mkIf config.mama.profiles.graphical.enable {
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
