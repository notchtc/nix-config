{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  zcompdump = "$HOME/" + config.programs.zsh.dotDir + ".zcompdump";
in {
  nix = {
    package = pkgs.nix;
    settings.use-xdg-base-directories = true;
  };

  programs = {
    gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
      };

      extensions = lib.attrValues {
        inherit
          (pkgs)
          gh-cal
          gh-dash
          gh-eco
          ;
      };
    };

    git = {
      enable = true;
      userName = "chtc";
      userEmail = "chtc@tuta.io";
    };

    home-manager = {
      enable = true;
      path = "${inputs.home}";
    };

    zsh = {
      enable = true;
      shellAliases = import ./config/shell-aliases.nix;

      autocd = true;
      dotDir = ".config/zsh";
      history.path = "${config.xdg.stateHome}/zsh/history";

      plugins = [
        {
          name = "F-Sy-H";
          src = inputs.f-sy-h; 
        }
        {
          name = "zsh-autosuggestions";
          src = inputs.zsh-autosuggestions;
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
        PROMPT='%{%(?.%F{green}.%F{red})%}%~ %F{reset}'
      '';
    };
  };
}
