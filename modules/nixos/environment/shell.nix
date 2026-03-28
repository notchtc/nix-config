{ pkgs, ... }:
{
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shellInit = "umask 0077";
    shells = [ pkgs.zsh ];
  };
}
