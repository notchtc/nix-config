{ config, inputs, ... }:
{
  imports = [ "${inputs.nix-mineral.result}/nix-mineral.nix" ];

  nix-mineral = {
    enable = true;
    overrides = {
      compatibility = {
        allow-unsigned-modules = true;
        allow-ip-forward = true;
        no-lockdown = true;
      };
      desktop.doas-sudo-wrapper = true;
      performance.allow-smt = true;
      security = {
        disable-bluetooth-kmodules = true;
        disable-intelme-kmodules = true;
        lock-root = true;
      };
      software-choice = {
        doas-no-sudo = true;
        secure-chrony = true;
      };
    };
  };

  services.dbus.apparmor = "enabled";
  security = {
    protectKernelImage = true;
    unprivilegedUsernsClone = config.virtualisation.containers.enable;

    auditd.enable = true;
    apparmor.enableCache = true;
    audit = {
      backlogLimit = 8192;
      failureMode = "printk";
      rules = [ "-a exit,always -F arch=b64 -S execve" ];
    };
  };
}
