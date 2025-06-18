{
  project,
  lib,
  pkgs,
  host ? builtins.throw "No host name provided",
  ...
}:
{
  imports = [
    project.inputs.chaotic.result.nixosModules.default
    project.inputs.nix-index-database.result.nixosModules.nix-index
    ./boot.nix
    ./conditions.nix
    ./doas.nix
    ./fish.nix
    ./memory.nix
    ./networking.nix
    ./nix.nix
  ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      bottom
      deadnix
      eza
      fd
      ffmpeg
      nixfmt-rfc-style
      npins
      p7zip
      ripgrep
      statix
      zoxide
      ;
  };

  services = {
    dbus.implementation = "broker";
    openssh.enable = true;
    userborn.enable = true;
  };

  programs = {
    bat.enable = true;
    command-not-found.enable = false;
    git.enable = true;
    nano.enable = false;
    nix-index-database.comma.enable = true;
    bash.shellInit = ''
      export HISTFILE="$XDG_STATE_HOME"/bash/history
    '';

    vim = {
      enable = true;
      defaultEditor = true;
    };
  };

  home-manager.backupFileExtension = "backup";
  networking.hostName = host;
  system.etc.overlay.enable = true;
}
