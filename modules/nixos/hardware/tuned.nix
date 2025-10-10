{ config, lib, ... }:
{
  services = lib.mkIf config.mama.profiles.laptop.enable {
    power-profiles-daemon.enable = false;
    tlp.enable = false;
    tuned.enable = true;
  };
}
