{ config, ... }:
{
  home.sessionVariables = {
    PAGER = "less -FR";
    SYSTEMD_PAGERSECURE = "true";
    VISUAL = config.home.sessionVariables.EDITOR;
  };
}
