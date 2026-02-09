{ config, lib, ... }:
{
  imports = [
    ./niri.nix
    ./services.nix
    ./theming.nix
  ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    boot.plymouth.enable = true;
    environment.variables.NIXOS_OZONE_WL = 1;
    programs.dconf.enable = true;
  };
}
