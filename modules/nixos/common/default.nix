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
    ./i18n.nix
    ./impermanence.nix
    ./memory.nix
    ./networking.nix
    ./nix.nix
    ./shell.nix
  ];

  environment = {
    defaultPackages = lib.mkForce [ ];
    systemPackages = lib.attrValues {
      inherit (pkgs)
        _7zz-rar
        bottom
        busybox
        deadnix
        eza
        fd
        ffmpeg
        git
        nixfmt
        npins
        ragenix
        ripgrep
        statix
        ;
    };
  };

  hardware.enableRedistributableFirmware = true;
  services.dbus.implementation = "broker";
  system.tools.nixos-generate-config.enable = false;
  documentation = {
    info.enable = false;
    nixos.enable = false;
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
