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

      aliases = {
        df = "difftool";
        a = "add";
        p = "push";
        r = "rebase";
        ri = "rebase -i";
        cm = "commit";
        pl = "pull";
        s = "status";
        st = "stash";
        ck = "checkout";
        rl = "reflog";
      };

      extraConfig = {
        diff.tool = "difftastic";
        pager.difftool = true;

        difftool = {
          prompt = false;
          difftastic.cmd = ''${lib.getExe pkgs.difftastic} "$LOCAL" "$REMOTE"'';
        };
      };
    };

    home-manager = {
      enable = true;
      path = "${inputs.home}";
    };

    dircolors = {
      enable = true;

      extraConfig = builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS";
        hash = "sha256-1a9pvv8kgy7cx0vkxyr7lvq2hs04pkg9nql73za9y39s2w8gyj3d";
      });
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

    nix-index.enable = true;
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
      enableCompletion = false;
      enableAutosuggestions = true;
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
