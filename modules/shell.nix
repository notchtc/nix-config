{
  config.modules.nixos.shell =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib.meta) getExe;
    in
    {
      users.defaultUserShell = pkgs.zsh;

      environment = {
        sessionVariables.DO_NOT_TRACK = 1;
        shellInit = "umask 0077";
        shells = [ pkgs.zsh ];
      };

      programs = {
        bash.shellInit = ''
          export HISTFILE="$HOME/.local/share/bash/history"
        '';

        zsh = {
          enable = true;
          autosuggestions.enable = true;

          histFile = "$HOME/.local/share/zsh/history";
          histSize = 100000;
          vteIntegration = true;

          setOptions = [
            "AUTOCD"
            "GLOBDOTS"
            "HIST_EXPIRE_DUPS_FIRST"
            "HIST_IGNORE_ALL_DUPS"
            "HIST_IGNORE_SPACE"
            "HIST_REDUCE_BLANKS"
            "INTERACTIVE_COMMENTS"
            "PROMPT_SUBST"
            "SHARE_HISTORY"
          ];

          shellAliases = {
            "7z" = "7zz";
            cat = "bat -p";
            du = "dust";
            e = "$EDITOR";
            eza = "eza --icons auto --color auto --git --group-directories-first --header";
            find = "fd";
            grep = "rg";
            la = "eza -a";
            less = "moor";
            ll = "eza -l";
            lla = "eza -la";
            ls = "eza";
            lt = "eza --tree";
          };

          loginShellInit = "${config.hjem.users.chtc.environment.loadEnv}";

          shellInit = "zsh-newuser-install () {}";

          interactiveShellInit = ''
            source "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
            stty stop undef

            bindkey -M menuselect 'h' vi-backward-char
            bindkey -M menuselect 'k' vi-up-line-or-history
            bindkey -M menuselect 'l' vi-forward-char
            bindkey -M menuselect 'j' vi-down-line-or-history

            zstyle ':completion:*' menu select

            eval "$(${getExe pkgs.zsh-patina} activate)"
          '';

          promptInit = ''
            autoload -Uz vcs_info
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
          '';
        };
      };
    };
}
