{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nur.hmModules.nur
    inputs.chaotic.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
    ./shell
    ./xdg.nix
  ];

  home = {
    packages = with pkgs; [ trash-cli ];
    stateVersion = "24.05";
  };

  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    command-not-found.enable = false;
  };

  systemd.user.startServices = "sd-switch";
}
