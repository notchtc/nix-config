{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  var = config.home.sessionVariables;
in
{
  home.sessionVariables = {
    SYSTEMD_EDITOR = var.EDITOR;
    VISUAL = var.EDITOR;
    TERMINAL = "${pkgs.foot}/bin/footclient";

    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";

  }
  // lib.optionalAttrs osConfig.mama.profiles.graphical.enable {
    BROWSER = "${pkgs.librewolf}/bin/librewolf";
  };
}
