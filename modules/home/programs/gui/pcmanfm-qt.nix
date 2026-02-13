{ lib, profiles, ... }:
{
  config = lib.mkIf profiles.graphical.enable {
    xdg.configFile."pcmanfm-qt/default/settings.conf".text = lib.generators.toINI { } {
      Behavior = {
        AutoSelectionDelay = 600;
        BookmarkOpenMethod = "current_tab";
        ConfirmDelete = true;
        ConfirmTrash = false;
        CtrlRightClick = false;
        NoUsbTrash = false;
        QuickExec = false;
        RecentFilesNumber = 0;
        SelectNewFiles = false;
        SingleClick = false;
        SingleWindowMode = false;
        UseTrash = false;
      };

      FolderView = {
        BackupAsHidden = false;
        BigIconSize = 48;
        CustomColumnWidths = "@Invalid()";
        FolderViewCellMargins = "@Size(3 3)";
        HiddenColumns = "@Invalid()";
        Mode = "icon";
        NoItemTooltip = false;
        ScrollPerPixel = true;
        ShadowHidden = true;
        ShowFilter = false;
        ShowFullNames = true;
        ShowHidden = false;
        SidePaneIconSize = 24;
        SmallIconSize = 24;
        SortCaseSensitive = false;
        SortColumn = "name";
        SortFolderFirst = true;
        SortHiddenLast = false;
        SortOrder = "ascending";
        ThumbnailIconSize = 128;
      };

      Places = {
        HiddenPlaces = "@Invalid()";
      };

      Search = {
        ContentPatterns = "@Invalid()";
        MaxSearchHistory = 0;
        NamePatterns = "@Invalid()";
        searchContentCaseInsensitive = false;
        searchContentRegexp = true;
        searchNameCaseInsensitive = false;
        searchNameRegexp = true;
        searchRecursive = false;
        searchhHidden = false;
      };

      System = {
        Archiver = "ark";
        FallbackIconThemeName = "oxygen";
        OnlyUserTemplates = false;
        SIUnit = false;
        TemplateRunApp = false;
        TemplateTypeOnce = false;
        Terminal = "ghostty";
      };

      Thumbnail = {
        MaxExternalThumbnailFileSize = -1;
        MaxThumbnailFileSize = 4096;
        ShowThumbnails = true;
        ThumbnailLocalFilesOnly = true;
      };

      Volume = {
        AutoRun = true;
        CloseOnUnmount = true;
        MountOnStartup = true;
        MountRemovable = true;
      };

      Window = {
        AlwaysShowTabs = true;
        PathBarButtons = true;
        RememberWindowSize = true;
        ReopenLastTabs = false;
        ShowMenuBar = true;
        ShowTabClose = true;
        SidePaneMode = "dirtree";
        SidePaneVisible = true;
        SplitView = false;
        SplitViewTabsNum = 0;
        SplitterPos = 150;
        SwitchToNewTab = false;
        TabPaths = "@Invalid()";
      };
    };
  };
}
