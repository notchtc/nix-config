{ config, ... }:
{
  imports = [
    ./bat.nix
    ./dircolors.nix
    ./eza.nix
    ./git.nix
    ./helix.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  programs = {
    gpg.homedir = "${config.xdg.dataHome}/gnupg";
    bash.historyFile = "${config.xdg.stateHome}/bash/history";
  };

  home.sessionVariables = {
    GNUPGHOME = "${config.programs.gpg.homedir}";
    LESSHISTFILE = "-";
    PAGER = "less";
    WINEPREFIX = "${config.xdg.dataHome}/wine";
  };
}
