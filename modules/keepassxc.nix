{
  config.modules.home.keepassxc =
    { lib, pkgs, ... }:
    let
      inherit (lib.meta) getExe;
    in
    {
      rum.programs.keepassxc = {
        enable = true;

        settings = {
          GUI = {
            ApplicationTheme = "dark";
            MinimizeOnClose = true;
            MinimizeOnStartup = true;
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

      systemd.services.keepassxc = {
        description = "KeepassXC";
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];

        serviceConfig.ExecStart = getExe pkgs.keepassxc;
      };
    };
}
