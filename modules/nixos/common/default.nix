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
    ./memory.nix
    ./networking.nix
    ./nix.nix
    ./zsh.nix
  ];

  environment = {
    shellAliases = with pkgs; {
      e = "$EDITOR";
      cat = "${lib.getExe bat} -Pp";
      ls = "${lib.getExe eza} --classify=auto --group-directories-first";
    };
    systemPackages = lib.attrValues {
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
        ;
    };
  };

  services = {
    dbus.implementation = "broker";
    openssh.enable = true;
    userborn.enable = true;
  };

  programs = {
    bat.enable = true;
    git.enable = true;
    nano.enable = false;
    nix-index-database.comma.enable = true;
    zoxide.enable = true;

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
