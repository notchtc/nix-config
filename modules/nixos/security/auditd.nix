{
  security = {
    auditd.enable = true;
    audit = {
      backlogLimit = 8192;
      failureMode = "printk";
      rules = [ "-a exit,always -F arch=b64 -S execve" ];
    };
  };

  services.logrotate.settings."/var/log/audit/audit.log" = {
    frequency = "daily";
    minsize = "500M";
    rotate = 3;
  };
}
