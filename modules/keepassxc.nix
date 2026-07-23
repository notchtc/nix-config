{
  config.modules.home.keepassxc =
    { lib, pkgs, ... }:
    let
      inherit (lib.generators) toINI;
    in
    {
      packages = [ pkgs.keepassxc ];

      xdg.config.files."keepassxc/keepassxc.ini" = {
        generator = toINI { };
        value = {
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
