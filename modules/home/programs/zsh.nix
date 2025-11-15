{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) getExe mkOrder;
  zcompdump = "${config.xdg.configHome}/zsh/.zcompdump";
in
{
  home.file.".zshenv".enable = false;
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    sessionVariables.ZSH_AUTOSUGGEST_MANUAL_REBIND = 1;

    history = {
      path = "${config.xdg.stateHome}/zsh/history";

      save = 100000;
      size = 100000;

      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    setOptions = [
      "autocd"
      "globdots"
      "interactive_comments"
      "prompt_subst"
    ];

    shellAliases = with pkgs; {
      "7z" = getExe _7zz-rar;
      cat = "${getExe bat} -p";
      du = getExe dust;
      e = "$EDITOR";
      find = getExe fd;
      grep = getExe ripgrep;
      man = getExe bat-extras.batman;
    };

    completionInit = ''
      autoload -Uz compinit
      zmodload zsh/complist
      compinit -d "${zcompdump}"
    '';

    loginExtra = ''
      {
        if [[ -s "${zcompdump}" && (! -s "${zcompdump}.zwc" || "${zcompdump}" -nt "${zcompdump}.zwc") ]]; then
          zcompile "${zcompdump}"
        fi
      } &!
    '';

    initContent = mkOrder 1000 ''
      autoload -Uz add-zsh-hook
      autoload -U colors && colors
      autoload -Uz vcs_info

      export KEYTIMEOUT=1
      stty stop undef

      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      add-zsh-hook precmd vcs_info

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
      add-zsh-hook -Uz chpwd chpwd-osc7-pwd

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

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    envExtra = ''
      setopt no_global_rcs
    '';
  };
}
