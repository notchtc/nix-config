{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf osConfig.mama.profiles.graphical.enable {
    home.packages = [ pkgs.haruna ];

    xdg.configFile."haruna/haruna.conf".text = lib.generators.toINI { } {
      "General" = {
        FloatingFooterTrigger = "BottomMouseMovement";
        FooterStyle = "floating";
        ShowHeader = false;
        ShowMenuBar = false;
        ShowPreviewThumbnail = true;
      };

      "Playback".RestoreFilePosition = true;

      "Playlist" = {
        PlaybackBehavior = "StopAfterLast";
        Position = "left";
      };
    };
  };
}
