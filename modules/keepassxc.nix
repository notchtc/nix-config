{
  config.modules.home.keepassxc = {
    rum.programs.keepassxc = {
      enable = true;

      settings = {
        GUI = {
          MinimizeOnClose = true;
          ShowTrayIcon = true;
          ToolButtonStyle = 4;
          TrayIconAppearance = "monochrome-light";
        };

        Security = {
          ClearSearch = true;
          HideTotpPreviewPanel = true;
        };

        Browser.Enabled = true;
        General.ConfigVersion = 2;
      };
    };
  };
}
