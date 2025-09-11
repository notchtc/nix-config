{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.laptop.enable {
    services = {
      power-profiles-daemon.enable = false;
      tlp.enable = false;
      tuned.enable = true;
    };
  };
}
