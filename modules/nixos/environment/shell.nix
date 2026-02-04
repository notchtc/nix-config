{ pkgs, ... }:
{
  environment = {
    shellInit = "umask 0077";
    shells = [ pkgs.zsh ];
  };
}
