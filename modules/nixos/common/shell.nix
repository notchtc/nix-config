{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    localBinInPath = true;
    shellInit = "umask 0077";
    shells = [ pkgs.zsh ];
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = false;

      shellInit = ''
        export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
      '';
    };

    nano.enable = false;
    bash.shellInit = ''
      export HISTFILE="$XDG_STATE_HOME"/bash/history
    '';
    vim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
