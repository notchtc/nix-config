{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionalAttrs;
  graphical = config.mama.profiles.graphical.enable;
in
{
  home.sessionVariables = {
    PAGER = "less -FR";
    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";
    VISUAL = config.home.sessionVariables.EDITOR;
  }
  // optionalAttrs graphical {
    BROWSER = "schizofox";
    TERMINAL = "${pkgs.ghostty}/bin/ghostty";
  };
}
