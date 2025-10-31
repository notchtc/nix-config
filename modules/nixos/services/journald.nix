{ config, lib, ... }:
let
  inherit (lib) mkIf;
  server = config.mama.profiles.server.enable;
in
{
  services.journald.extraConfig = mkIf (!server) ''
    SystemMaxUse=100M
    RuntimeMaxUse=50M
    SystemMaxFileUse=50M
  '';
}
