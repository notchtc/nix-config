{
  services.snowflake-proxy.enable = true;
  systemd.services.snowflake-proxy.unitConfig.ConditionACPower = true;
}
