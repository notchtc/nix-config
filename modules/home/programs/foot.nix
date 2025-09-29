{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mama.programs.foot.enable = lib.mkEnableOption "Foot terminal";
  config = lib.mkIf config.mama.programs.foot.enable {
    home.sessionVariables.TERMINAL = "${pkgs.foot}/bin/footclient";
    xdg.terminal-exec.settings.default = [ "footclient.desktop" ];
    programs.foot = {
      enable = true;
      server.enable = true;

      settings = {
        main = {
          pad = "6x6 center";
        };

        cursor = {
          style = "beam";
          blink = "yes";
        };
      };
    };
  };
}
