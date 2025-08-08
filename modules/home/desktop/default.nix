{ inputs }:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./foot.nix
    ./mpv.nix
    ./niri
    (import ./schizofox.nix { inherit inputs; })
    ./theme.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        cardinal
        fooyin
        gimp3
        gpu-screen-recorder-gtk
        nautilus
        nicotine-plus
        papers
        picard
        plugdata
        qbittorrent
        qpwgraph
        telegram-desktop
        ;
    };

    file."${config.xdg.configHome}/fooyin/layout.fyl".source = ./layout.fyl;

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland";
    };
  };

  services.playerctld.enable = true;

  programs = {
    foliate.enable = true;
    keepassxc.enable = true;
    swayimg.enable = true;
    vesktop = {
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
  };
}
