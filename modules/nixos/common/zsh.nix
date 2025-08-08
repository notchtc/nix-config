{ pkgs, ... }:
{
  environment = {
    localBinInPath = true;
    shells = [ pkgs.zsh ];
  };
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;

    histFile = "$XDG_STATE_HOME/zsh/history";
    histSize = 100000;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    setOptions = [
      "autocd"
      "globdots"
      "interactive_comments"
      "prompt_subst"
    ];

    shellInit = ''
      export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
      zsh-newuser-install () {}
    '';

    interactiveShellInit = ''
      bindkey -v
      zstyle ':completion:*' menu select  
      stty stop undef

      echo -ne '\e[5 q'
      preexec() { echo -ne '\e[5 q' ;}
    '';

    promptInit = ''
      autoload -U colors && colors
      autoload -Uz vcs_info

      precmd() {
        vcs_info
      }

      zstyle ":vcs_info:git:*" formats "%F{green}%b%f"
      PROMPT='%F{blue}%3~%f %(?.%F{green}λ.%F{red}λ%f) '
      RPROMPT=' ''${vcs_info_msg_0_}'
    '';
  };
}
