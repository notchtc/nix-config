{ lib, profiles, ... }:
{
  programs.noctalia-shell.settings.controlCenter = lib.mkIf profiles.graphical.enable {
    shortcuts = {
      left = [
        { id = "Notifications"; }
        { id = "Bluetooth"; }
      ];
      right = [
        { id = "NoctaliaPerformance"; }
        { id = "PowerProfile"; }
        { id = "KeepAwake"; }
        { id = "NightLight"; }
      ];
    };

    cards = [
      {
        id = "profile-card";
        enabled = true;
      }
      {
        id = "shortcuts-card";
        enabled = true;
      }
      {
        id = "audio-card";
        enabled = true;
      }
      {
        id = "brightness-card";
        enabled = true;
      }
      {
        id = "weather-card";
        enabled = false;
      }
      {
        id = "media-sysmon-card";
        enabled = true;
      }
    ];
  };
}
