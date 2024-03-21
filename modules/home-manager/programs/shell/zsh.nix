{ inputs, config, ... }:
let
  zcompdump = "$HOME/" + config.programs.zsh.dotDir + ".zcompdump";
in
{
  programs = {
    zsh = {
      enable = true;
      shellAliases = import ./shell-aliases.nix;

      autocd = true;
      enableCompletion = false;
      autosuggestion.enable = true;
      dotDir = ".config/zsh";

      history = {
        path = "${config.xdg.stateHome}/zsh/history";

        expireDuplicatesFirst = true;
        extended = true;
      };

      plugins = [
        {
          name = "F-Sy-H";
          src = inputs.f-sy-h;
        }
        {
          name = "zsh-autocomplete";
          src = inputs.zsh-autocomplete;
        }
        {
          name = "zsh-nix-shell";
          src = inputs.zsh-nix-shell;
          file = "nix-shell.plugin.zsh";
        }
      ];

      loginExtra = ''
        # Execute code in the background to not affect the current session
        {
          # Compile zcompdump, if modified, to increase startup speed.
          if [[ -s "${zcompdump}" && (! -s "${zcompdump}.zwc" || "${zcompdump}" -nt "${zcompdump}.zwc") ]]; then
            zcompile "${zcompdump}"
          fi
        } &!
      '';

      completionInit = ''
        autoload -Uz compinit
        if [[ -n ${zcompdump}(#qN.mh+24) ]]; then
        	compinit;
        else
        	compinit -C;
        fi;
      '';

      initExtra = ''
        bindkey -v

        bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
        bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

        # all Tab widgets
        zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

        # all history widgets
        zstyle ':autocomplete:*history*:*' insert-unambiguous yes

        # ^S
        zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

        +autocomplete:recent-directories() {
          typeset -ga reply=( ''${(f)"$(zoxide query -l)"})
        }
      '';
    };
  };
}
