{
  project,
  lib,
  pkgs,
  host ? builtins.throw "No host name provided",
  system ? builtins.throw "No platform provided",
  ...
}:
{
  imports = [
    project.inputs.nix-index-database.result.nixosModules.nix-index
    ./boot.nix
    ./doas.nix
    ./fish.nix
    ./memory.nix
    ./networking.nix
    ./nix.nix
  ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      _7zz
      bottom
      deadnix
      eza
      fd
      ffmpeg
      nixfmt-rfc-style
      npins
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
  nixpkgs.hostPlatform = "${system}";
  system.etc.overlay.enable = true;
}
