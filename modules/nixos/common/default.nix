{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.chaotic.nixosModules.default
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.default
    ./boot.nix
    ./doas.nix
    ./networking.nix
    ./nix.nix
    ./run-ext-binaries.nix
    ./zram.nix
  ];

  environment = {
    localBinInPath = true;
    shells = [ pkgs.zsh ];

    systemPackages = lib.attrValues {
      inherit (pkgs)
        fd
        git
        ripgrep
        vim
        ;
    };
  };

  users.defaultUserShell = pkgs.zsh;

  console = {
    earlySetup = true;
    keyMap = "pl";
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

  programs = {
    command-not-found.enable = false;
    nano.enable = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh = {
      enable = true;
      enableCompletion = false;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  system.stateVersion = "24.05";

  home-manager = {
    extraSpecialArgs.inputs = inputs;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
