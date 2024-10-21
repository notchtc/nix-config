{
  inputs,
  perSystem,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.chaotic.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.default
    ./boot.nix
    ./doas.nix
    ./fish.nix
    ./networking.nix
    ./nix.nix
    ./run-ext-binaries.nix
    ./zram.nix
  ];

  environment = {
    localBinInPath = true;

    shellAliases = {
      e = "$EDITOR";
      se = "doas $EDITOR";
      cat = "bat";
      ls = "eza";
    };

    systemPackages = lib.attrValues {
      inherit (pkgs)
        bat
        btop
        deadnix
        eza
        fd
        ffmpeg
        nixfmt-rfc-style
        p7zip
        ripgrep
        statix
        zoxide
        ;
    };
  };

  console = {
    earlySetup = true;
    keyMap = "pl";
  };

  programs = {
    command-not-found.enable = false;
    git.enable = true;
    gnupg.agent.enable = true;
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "pl_PL.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_TIME = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
    };
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Warsaw";
  };

  system.stateVersion = "24.05";

  home-manager = {
    extraSpecialArgs.inputs = inputs;
    extraSpecialArgs.perSystem = perSystem;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
