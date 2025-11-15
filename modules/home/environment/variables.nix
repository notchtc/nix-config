{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionalAttrs;
  graphical = config.mama.profiles.graphical.enable;
  var = config.home.sessionVariables;
in
{
  home.sessionVariables = {
    SYSTEMD_EDITOR = var.EDITOR;
    VISUAL = var.EDITOR;

    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";
  }
  // optionalAttrs graphical {
    BROWSER = "librewolf";
    TERMINAL = "${pkgs.ghostty}/bin/ghostty";
  };
}
