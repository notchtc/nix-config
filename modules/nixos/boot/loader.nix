{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  secure-boot = config.mama.system.secure-boot.enable;
in
{
  options.mama.system.secure-boot.enable = mkEnableOption ''
    Enable secure boot in Limine
  '';

  config.boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
      enableEditor = false;
      maxGenerations = 10;
      secureBoot.enable = mkIf secure-boot true;
    };

    timeout = 1;
  };
}
