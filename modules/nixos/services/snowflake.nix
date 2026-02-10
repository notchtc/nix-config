{ pkgs, ... }:
{
  services = {
    udev.extraRules = ''
      SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${pkgs.systemd}/bin/systemctl stop snowflake-proxy.service"
      SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${pkgs.systemd}/bin/systemctl start snowflake-proxy.service"
    '';
    snowflake-proxy.enable = true;
  };
}
