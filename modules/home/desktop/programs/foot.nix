{ pkgs, ... }:
{
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
}
