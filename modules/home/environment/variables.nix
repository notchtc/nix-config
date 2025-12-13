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

    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";

  }
  // lib.optionalAttrs osConfig.mama.profiles.graphical.enable {
    BROWSER = "${pkgs.librewolf}/bin/librewolf";
    TERMINAL = "${pkgs.ghostty}/bin/ghostty";
  };
}
