{
  config,
  lib,
  osConfig,
  ...
}:
let
  var = config.home.sessionVariables;
in
{
  home.sessionVariables = {
    SYSTEMD_EDITOR = var.EDITOR;
    VISUAL = var.EDITOR;

    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";
  }
  // lib.optionalAttrs osConfig.mama.profiles.graphical.enable { BROWSER = "librewolf"; };
}
