{ lib, pkgs, ... }:
{
  imports = [
    ./foot.nix
    ./mpv.nix
    ./niri
    ./schizofox.nix
    ./theme.nix
    ./xdg.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        gimp3
        nautilus
        nicotine-plus
        papers
        picard
        plugdata
        qbittorrent
        strawberry
        telegram-desktop
        ;
    };

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

  xdg.desktopEntries."org.openmw.launcher" = {
    name = "OpenMW Launcher";
    genericName = "Role Playing Game";
    comment = "An engine replacement for The Elder Scrolls III: Morrowind";
    exec = lib.getExe (
      pkgs.writeShellScriptBin "openmw-launcher-wrapper" ''
        export OSG_VERTEX_BUFFER_HINT="VERTEX_BUFFER_OBJECT"

        ${lib.getExe pkgs.steam-run} ${lib.getExe' pkgs.gamemode "gamemoderun"} "$HOME/.local/bin/openmw/openmw-launcher"
      ''
    );
    prefersNonDefaultGPU = true;
    icon = "openmw";
    type = "Application";
    categories = [
      "Game"
      "RolePlaying"
    ];
    settings.Keywords = "Morrowind;Reimplementation;Mods;esm;bsa";
  };
}
