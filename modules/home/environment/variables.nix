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
    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";
    VISUAL = config.home.sessionVariables.EDITOR;
  }
  // optionalAttrs graphical {
    BROWSER = "librewolf";
    TERMINAL = "${pkgs.ghostty}/bin/ghostty";
  };
}
