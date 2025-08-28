{ lib, pkgs, ... }:
{
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    localBinInPath = true;
    shellInit = "umask 0077";
    shellAliases = with pkgs; {
      "7z" = "${lib.getExe _7zz-rar}";
      e = "$EDITOR";
      cat = "${lib.getExe bat} -Pp";
      ls = "${lib.getExe eza} --classify=auto --group-directories-first";
      man = "${lib.getExe pkgs.bat-extras.batman}";
      tree = "ls --tree";
    };
    shells = [ pkgs.zsh ];
  };
  users.defaultUserShell = pkgs.zsh;

  programs = {
    zsh = {
      enable = true;

      histFile = "$XDG_STATE_HOME/zsh/history";
      histSize = 100000;

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = false;
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
        autoload -Uz add-zsh-hook

        bindkey -v
        export KEYTIMEOUT=1
        stty stop undef

        zstyle ':completion:*' menu select  
        zmodload zsh/complist
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'l' vi-forward-char
        bindkey -M menuselect 'j' vi-down-line-or-history

        function osc7-pwd() {
          emulate -L zsh # also sets localoptions for us
          setopt extendedglob
          local LC_ALL=C
          printf '\e]7;file://%s%s\e\' $HOST ''${PWD//(#m)([^@-Za-z&-;_~])/%''${(l:2::0:)$(([##16]#MATCH))}}
        }

        function chpwd-osc7-pwd() {
          (( ZSH_SUBSHELL )) || osc7-pwd
        }
        add-zsh-hook -Uz chpwd chpwd-osc7-pwd
      '';

      promptInit = ''
        autoload -U colors && colors
        autoload -Uz vcs_info

        add-zsh-hook precmd vcs_info

        zstyle ":vcs_info:git:*" formats "%F{green}%b%f"
        PROMPT='%F{blue}%3~%f %(?.%F{green}λ.%F{red}λ)%f '
        RPROMPT=' ''${vcs_info_msg_0_}'

        function zle-keymap-select () {
          case $KEYMAP in
            vicmd) echo -ne '\e[1 q';;      # block
            viins|main) echo -ne '\e[5 q';; # beam
          esac
        }
        zle -N zle-keymap-select
        zle-line-init() {
          echo -ne "\e[5 q"
        }
        zle -N zle-line-init
        echo -ne '\e[5 q'
        preexec() { echo -ne '\e[5 q' ;}
      '';
    };

    nano.enable = false;
    nix-index-database.comma.enable = true;
    zoxide.enable = true;
    bash.shellInit = ''
      export HISTFILE="$XDG_STATE_HOME"/bash/history
    '';
    bat = {
      enable = true;
      extraPackages = lib.attrValues { inherit (pkgs.bat-extras) batman; };
    };
    vim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
