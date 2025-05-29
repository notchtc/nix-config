{
  lib,
  pkgs,
  ...
}:
{
  boot = {
    initrd.systemd.enable = lib.mkDefault true;
    enableContainers = lib.mkDefault false;
    loader.grub.enable = lib.mkDefault false;
  };

  environment = {
    defaultPackages = lib.mkDefault [ ];
    systemPackages = [
      pkgs.nixos-rebuild
    ];
  };

  system = {
    etc.overlay.enable = lib.mkDefault true;
    disableInstallerTools = lib.mkDefault true;
  };

  programs = {
    less.lessopen = lib.mkDefault null;
    command-not-found.enable = lib.mkDefault false;
  };

  services.userborn.enable = lib.mkDefault true;
  documentation.info.enable = lib.mkDefault false;
}
