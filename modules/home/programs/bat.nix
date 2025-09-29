{ config, ... }:
{
  programs.bat = {
    enable = true;
    config.pager = config.home.sessionVariables.PAGER;
  };
}
