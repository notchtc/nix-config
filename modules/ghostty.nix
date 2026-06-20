{
  config.modules.home.ghostty =
    { config, lib, ... }:
    let
      inherit (lib.meta) getExe;
      inherit (lib.modules) mkForce;
    in
    {
      xdg.config.files."xdg-terminals.list".text = ''
        com.mitchellh.ghostty.desktop
      '';

      rum.programs.ghostty = {
        enable = true;

        settings = {
          cursor-style = "bar";
          font-family = "monospace";
          theme = "Gruvbox Dark Hard";
          window-padding-x = 3;
          window-padding-y = 3;
          window-theme = "system";

          mouse-hide-while-typing = true;
          quit-after-last-window-closed = false;

          scrollback-limit = 100 * 1024 * 1024;
          shell-integration = "none";
        };
      };

      systemd.services."app-com.mitchellh.ghostty" = {
        description = "Ghostty";
        path = mkForce [ ];
        after = [
          "dbus.socket"
          "graphical-session.target"
        ];
        requires = [ "dbus.socket" ];
        wantedBy = [ "graphical-session.target" ];

        serviceConfig = {
          Type = "notify-reload";
          ReloadSignal = "SIGUSR2";
          BusName = "com.mitchellh.ghostty";
          ExecStart = "${getExe config.rum.programs.ghostty.package} --gtk-single-instance=true --initial-window=false";
        };
      };
    };
}
