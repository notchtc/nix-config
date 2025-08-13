{ osConfig, ... }:
{
  imports = [
    ./helix.nix
    ./vcs.nix
    ./xdg.nix
  ];

  home = {
    inherit (osConfig.system) stateVersion;
    sessionVariables.MANPAGER = ''
      sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'
    '';
  };

  programs = {
    command-not-found.enable = false;
    zsh.enable = true;
  };
}
