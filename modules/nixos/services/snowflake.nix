{ config, lib, ... }:
{
  services.snowflake-proxy.enable = lib.mkIf (!config.mama.profiles.laptop.enable) true;
}
