{
  config.modules = {
    nixos.shell =
      { lib, pkgs, ... }:
      let
        inherit (lib.meta) getExe;
      in
      {
        users.defaultUserShell = pkgs.zsh;

        environment = {
          binsh = getExe pkgs.dash;
          shellInit = "umask 0077";
          shells = [ pkgs.zsh ];
        };

        programs.zsh = {
          enable = true;
          enableCompletion = false;

          #shellInit = ''
          #  export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
          #'';
        };
      };

    home.shell =
      { config, pkgs, ... }:
      let
        zcompdump = "${config.xdg.state.directory}/zcompdump";
      in
      {
        rum.programs.zsh = {
          enable = true;

          loginConfig = ''
            {
              if [[ -s "${zcompdump}" && (! -s "${zcompdump}.zwc" || "${zcompdump}" -nt "${zcompdump}.zwc") ]]; then
                zcompile "${zcompdump}"
              fi
            } &!
          '';

          initConfig = ''

            autoload -Uz compinit
            zmodload zsh/complist
            compinit -d "${zcompdump}"

            HISTSIZE=100000
            SAVEHIST=100000
            HISTFILE="${config.xdg.state.directory}/zsh/history"

            setopt autocd
            setopt globdots
            setopt hist_expire_dups_first
            setopt hist_ignore_all_dups
            setopt hist_ignore_space
            setopt hist_reduce_blanks
            setopt interactive_comments
            setopt prompt_subst
            setopt share_history

            alias 7z=7zz
            alias cat='bat -p'
            alias du=dust
            alias e='$EDITOR'
            alias eza='eza --icons auto --color auto --git --group-directories-first --header'
            alias find=fd
            alias grep=rg
            alias la='eza -a'
            alias less=moor
            alias ll='eza -l'
            alias lla='eza -la'
            alias ls=eza
            alias lt='eza --tree'

            autoload -Uz vcs_info

            stty stop undef

            bindkey -M menuselect 'h' vi-backward-char
            bindkey -M menuselect 'k' vi-up-line-or-history
            bindkey -M menuselect 'l' vi-forward-char
            bindkey -M menuselect 'j' vi-down-line-or-history

            zstyle ':completion:*' menu select  
            zstyle ":vcs_info:git:*" formats "%F{green}%b%f"

            function osc7-pwd() {
              emulate -L zsh # also sets localoptions for us
              setopt extendedglob
              local LC_ALL=C
              printf '\e]7;file://%s%s\e\' $HOST ''${PWD//(#m)([^@-Za-z&-;_~])/%''${(l:2::0:)$(([##16]#MATCH))}}
            }
            function chpwd-osc7-pwd() {
              (( ZSH_SUBSHELL )) || osc7-pwd
            }

            precmd() { vcs_info }
            chpwd() { chpwd-osc7-pwd } 

            if [ -n "$IN_NIX_SHELL" ]; then
              PROMPT='%F{blue}%3~%f %(?.%F{green} .%F{red} )%f '
            else
              PROMPT='%F{blue}%3~%f %(?.%F{green}λ.%F{red}λ)%f '
            fi
            RPROMPT=' ''${vcs_info_msg_0_}'

            function zle-keymap-select () {
              case $KEYMAP in
                vicmd) print -n '\e[1 q';;      # block
                viins|main) print -n '\e[5 q';; # beam
              esac
            }
            zle -N zle-keymap-select
            zle-line-init() { print -n "\e[5 q" }
            zle -N zle-line-init

            print -n '\e[5 q'
            preexec() { print -n '\e[5 q' ;}

            . ${pkgs.vte}/etc/profile.d/vte.sh
          '';

          plugins = {
            autosuggestions.source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            highlighting.source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
            vi-mode.source = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          };
        };
      };
  };
}
