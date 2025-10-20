{ config, ... }:
{
  home.sessionVariables = {
    PAGER = "less -FR";
    SYSTEMD_PAGERSECURE = "true";
    SSH_ASKPASS_REQUIRE = "prefer";
    VISUAL = config.home.sessionVariables.EDITOR;
  };
}
