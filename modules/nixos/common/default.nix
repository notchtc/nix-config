{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    "${inputs.agenix.result}/modules/age.nix"
    inputs.home-manager.result.nixosModules.default
    inputs.nix-index-database.result.nixosModules.nix-index
    ./boot.nix
    ./hardening.nix
    ./impermanence.nix
    ./memory.nix
    ./networking.nix
    ./nix.nix
    ./zsh.nix
  ];

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shellAliases = with pkgs; {
      e = "$EDITOR";
      cat = "${lib.getExe bat} -Pp";
      ls = "${lib.getExe eza} --classify=auto --group-directories-first";
      man = "${lib.getExe pkgs.bat-extras.batman}";
      tree = "ls --tree";
    };
    shellInit = "umask 0077";

    defaultPackages = lib.mkForce [ ];
    systemPackages = lib.attrValues {
      inherit (pkgs)
        _7zz-rar
        bottom
        deadnix
        eza
        fd
        ffmpeg
        git
        lshw
        nixfmt
        npins
        pciutils
        ragenix
        ripgrep
        statix
        ;
    };
  };

  services = {
    dbus.implementation = "broker";
    openssh.enable = true;
  };

  programs = {
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

  system.tools.nixos-generate-config.enable = false;

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
