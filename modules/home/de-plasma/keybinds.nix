{
  programs.plasma = {
    shortcuts = {
      "services/org.kde.krunner.desktop"."_launch" = [
        "Meta"
        "Search"
      ];
    };
    hotkeys = {
      commands = {
        "launch-foot" = {
          name = "Launch Foot";
          key = "Meta+Return";
          command = "foot";
        };
      };
    };
  };
}
