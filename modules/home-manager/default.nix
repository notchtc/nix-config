{pkgs, ...}: {
  imports = [
    ./programs/editors/helix.nix
    ./programs/nix-index.nix
    ./programs/shell/bat.nix
    ./programs/shell/dircolors.nix
    ./programs/shell/eza.nix
    ./programs/shell/git.nix
    ./programs/shell/starship.nix
    ./programs/shell/zoxide.nix
    ./programs/shell/zsh.nix
  ];

  nix = {
    package = pkgs.nix;
    settings.use-xdg-base-directories = true;
  };

  programs.home-manager.enable = true;
}
