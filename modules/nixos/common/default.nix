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
    ./zsh.nix
  ];

  environment = {
    localBinInPath = true;
    shells = [ pkgs.zsh ];

    systemPackages = lib.attrValues {
      inherit (pkgs)
        bat
        eza
        fd
        ripgrep
        vim
        zoxide
        ;
    };
  };
  users.defaultUserShell = pkgs.zsh;

  console = {
    earlySetup = true;
    keyMap = "pl";
  };

  programs = {
    command-not-found.enable = false;
    git.enable = true;
    gnupg.agent.enable = true;
    nano.enable = false;
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
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
