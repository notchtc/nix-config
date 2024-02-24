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

    helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "base16_transparent";

        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
      };
    };

    nix-index-database.comma.enable = true;

    bat = {
      enable = true;
      config = {
        style = "plain";
        theme = "base16";
      };
    };

    eza = {
      enable = true;
      enableAliases = false;
    };

    starship = {
      enable = true;
      settings = import ./config/starship.nix;
    };

    zoxide = {
      enable = true;
    };

    zsh = {
      enable = true;
      shellAliases = import ./config/shell-aliases.nix;

      autocd = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      history = {
        path = "${config.xdg.stateHome}/zsh/history";

        expireDuplicatesFirst = true;
        extended = true;
      };

      plugins = [
        {
          name = "zsh-history-substring-search";
          src = inputs.zsh-history-substring-search;
        }
        {
          name = "F-Sy-H";
          src = inputs.f-sy-h;
        }
        {
          name = "zsh-autosuggestions";
          src = inputs.zsh-autosuggestions;
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

        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey '^[OA' history-substring-search-up
        bindkey '^[OB' history-substring-search-down
      '';
    };
  };
}
