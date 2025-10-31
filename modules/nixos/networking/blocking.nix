{ config, lib, ... }:
let
  inherit (lib) mkIf;
  server = config.mama.profiles.server.enable;
in
{
  networking.stevenblack = mkIf (!server) {
    enable = true;
    block = [
      "fakenews"
      "gambling"
    ];
  };
}
