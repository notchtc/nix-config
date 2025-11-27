{ config, lib, ... }:
{
  services.journald.extraConfig = lib.mkIf (!config.mama.profiles.server.enable) ''
    SystemMaxUse=100M
    RuntimeMaxUse=50M
    SystemMaxFileUse=50M
  '';
}
