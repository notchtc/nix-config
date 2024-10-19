{ pkgs, ... }:
{
  imports = [ ./starship.nix ];

  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    setOptions = [
      "autocd"
      "globdots"
    ];

    histFile = "$XDG_STATE_HOME/zsh/history";
    histSize = 100000;

    shellInit = ''
      export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
      zsh-newuser-install () {}
    '';

    interactiveShellInit = ''
      bindkey -v

      eval "$(zoxide init zsh)"
    '';
  };
}
