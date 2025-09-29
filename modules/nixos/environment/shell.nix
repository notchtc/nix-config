{ pkgs, ... }:
{
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    localBinInPath = true;
    shellInit = "umask 0077";
    shells = [ pkgs.zsh ];
  };
}
