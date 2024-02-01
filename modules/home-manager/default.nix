{
  config,
  inputs,
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
          src = pkgs.fetchFromGitHub {
            owner = "z-shell";
            repo = "F-Sy-H";
            rev = "v1.67";
            hash = "sha256-zhaXjrNL0amxexbZm4Kr5Y/feq1+2zW0O6eo9iZhmi0=";
          };
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
            hash = "sha256-B+Kz3B7d97CM/3ztpQyVkE6EfMipVF8Y4HJNfSRXHtU=";
          };
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
