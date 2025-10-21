{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    PAGER = "less -FR";
    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";
    VISUAL = config.home.sessionVariables.EDITOR;
  }
  // lib.optionalAttrs config.mama.profiles.graphical.enable {
    BROWSER = "schizofox";
    TERMINAL = "${pkgs.ghostty}/bin/ghostty";
  };
}
