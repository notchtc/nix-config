{
  self,
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    self.homeModules.helix
    self.homeModules.bat
    self.homeModules.dircolors
    self.homeModules.eza
    self.homeModules.git
    self.homeModules.starship
    self.homeModules.zoxide
    self.homeModules.zsh

    inputs.nix-index-database.hmModules.nix-index
  ];

  home.packages = lib.attrValues { inherit (pkgs) trash-cli wl-clipboard; };

  nix = {
    package = pkgs.nix;
    settings.use-xdg-base-directories = true;
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [ self.overlays.default ];
  };

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    command-not-found.enable = false;
  };

  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";
    };
  };

  systemd.user.startServices = "sd-switch";
}
