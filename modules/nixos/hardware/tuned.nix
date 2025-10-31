{ config, lib, ... }:
let
  inherit (lib) mkIf;
  laptop = config.mama.profiles.laptop.enable;
in
{
  services = mkIf laptop {
    power-profiles-daemon.enable = false;
    tlp.enable = false;
    tuned.enable = true;
  };
}
