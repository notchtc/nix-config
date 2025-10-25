{ config, lib, ... }:
{
  options.mama.system.secure-boot.enable = lib.mkEnableOption ''
    Enable secure boot in Limine
  '';

  config.boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
      enableEditor = false;
      maxGenerations = 10;
      secureBoot.enable = lib.mkIf config.mama.system.secure-boot.enable true;
    };

    timeout = 1;
  };
}
