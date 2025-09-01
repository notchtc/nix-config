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
    ./boot.nix
    ./hardening.nix
    ./i18n.nix
    ./memory.nix
    ./networking.nix
    ./nix.nix
    ./preservation.nix
    ./shell.nix
  ];

  hardware.enableRedistributableFirmware = true;
  environment = {
    defaultPackages = lib.mkForce [ ];
    systemPackages = lib.attrValues {
      inherit (pkgs)
        _7zz-rar
        busybox
        deadnix
        ffmpeg
        gitMinimal
        nixfmt
        npins
        ragenix
        statix
        ;
    };
  };

  documentation = {
    info.enable = false;
    nixos.enable = false;
  };

  services = {
    dbus.implementation = "broker";
    userborn = {
      enable = true;
      passwordFilesLocation = "/persist/etc";
    };
  };

  system = {
    etc.overlay.enable = true;
    tools.nixos-generate-config.enable = false;
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
