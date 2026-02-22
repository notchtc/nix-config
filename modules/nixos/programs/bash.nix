{
  programs.bash.shellInit = ''
    export HISTFILE="$XDG_STATE_HOME"/bash/history
  '';
}
