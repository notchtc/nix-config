{
  config,
  lib,
  pkgs,
  profiles,
  ...
}:
{
  home.sessionVariables = {
    SYSTEMD_EDITOR = config.home.sessionVariables.EDITOR;

    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";

  }
  // lib.optionalAttrs profiles.graphical.enable {
    BROWSER = "${pkgs.librewolf}/bin/librewolf";
    TERMINAL = "${pkgs.ghostty}/bin/ghostty";
  };
}
