{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mama.programs.ghostty.enable = lib.mkEnableOption "Ghostty terminal";
  config = lib.mkIf config.mama.programs.ghostty.enable {
    home.sessionVariables.TERMINAL = "${pkgs.ghostty}/bin/ghostty";
    xdg.terminal-exec.settings.default = [ "com.mitchellh.ghostty.desktop" ];
    programs.ghostty = {
      enable = true;
      settings = {
        cursor-style = "bar";
        font-family = "Sarasa Term J";
        font-size = 11;
        theme = "Adwaita Dark";
        window-padding-x = 6;
        window-padding-y = 6;
        window-theme = "ghostty";
      };
    };
  };
}
