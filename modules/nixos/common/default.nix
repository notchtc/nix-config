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
    "${project.inputs.agenix.result}/modules/age.nix"
    project.inputs.nix-index-database.result.nixosModules.nix-index
    ./boot.nix
    ./doas.nix
    ./memory.nix
    ./networking.nix
    ./nix.nix
    ./zsh.nix
  ];

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shellAliases = with pkgs; {
      e = "$EDITOR";
      se = "doas $EDITOR";
      cat = "${lib.getExe bat} -Pp";
      ls = "${lib.getExe eza} --classify=auto --group-directories-first";
      man = "${lib.getExe pkgs.bat-extras.batman}";
      tree = "ls --tree";
    };

    defaultPackages = lib.mkForce [ ];
    systemPackages = lib.attrValues {
      inherit (pkgs)
        _7zz-rar
        bottom
        deadnix
        dua
        eza
        fd
        ffmpeg
        lshw
        nixfmt
        npins
        pciutils
        ragenix
        ripgrep
        statix
        ;

      uutils = pkgs.hiPrio pkgs.uutils-coreutils-noprefix;
    };
  };

  services = {
    dbus.implementation = "broker";
    openssh.enable = true;
    userborn.enable = true;
  };

  programs = {
    git.enable = true;
    nano.enable = false;
    nix-index-database.comma.enable = true;
    zoxide.enable = true;

    bash.shellInit = ''
      export HISTFILE="$XDG_STATE_HOME"/bash/history
    '';

    bat = {
      enable = true;
      extraPackages = lib.attrValues { inherit (pkgs.bat-extras) batman; };
    };

    vim = {
      enable = true;
      defaultEditor = true;
    };
  };

  documentation = {
    info.enable = false;
    nixos.enable = false;
  };

  system = {
    etc.overlay.enable = true;
    tools.nixos-generate-config.enable = false;
  };

  home-manager.backupFileExtension = "backup";
  networking.hostName = host;
  nixpkgs.hostPlatform = "${system}";
}
