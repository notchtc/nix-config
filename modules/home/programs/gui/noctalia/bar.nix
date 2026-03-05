{ lib, profiles, ... }:
{
  programs.noctalia-shell.settings.bar = lib.mkIf profiles.graphical.enable {
    barType = "simple";
    contentPadding = 3;
    displayMode = "always_visible";
    floating = false;
    outerCorners = false;
    position = "left";
    showCapsule = false;
    widgetSpacing = 6;
    widgets = {
      left = [
        {
          id = "Workspace";
          labelMode = "none";
          pillSize = 0.45;
        }
        { id = "plugin:privacy-indicator"; }
      ];
      center = [ ];
      right = [
        { id = "MediaMini"; }
        {
          id = "Tray";
          drawerEnabled = false;
        }
        { id = "NotificationHistory"; }
        { id = "Brightness"; }
        {
          id = "Battery";
          hideIfIdle = true;
          showNoctaliaPerformance = true;
          showPowerProfiles = true;
        }
        { id = "Volume"; }
        {
          id = "Clock";
          formatVertical = "HH mm";
        }
        {
          id = "ControlCenter";
          useDistroLogo = true;
        }
      ];
    };
  };
}
