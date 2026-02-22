{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = false;

      shellInit = ''
        export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
      '';
    };
  };
}
