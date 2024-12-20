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
    ./fish.nix
    ./memory.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
  ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
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

  services = {
    dbus.implementation = "broker";
    openssh.enable = true;
  };

  console.keyMap = "pl";
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

  system = {
    rebuild.enableNg = true;
    stateVersion = "24.11";
  };

  home-manager = {
    extraSpecialArgs.inputs = inputs;
    extraSpecialArgs.perSystem = perSystem;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
