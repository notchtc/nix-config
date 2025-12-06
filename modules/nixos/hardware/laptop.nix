{ config, lib, ... }:
{
  config = lib.mkIf config.mama.profiles.laptop.enable {
    boot.kernelParams = [ "rcutree.enable_rcu_lazy=1" ];

    services = {
      power-profiles-daemon.enable = false;
      tlp.enable = false;
      tuned = {
        enable = true;
        ppdSettings = {
          main.default = "balanced";
          profiles = {
            balanced = "balanced";
            performance = "throughput-performance";
            power-saver = "laptop-ac-powersave";
          };
          battery = {
            balanced = "balanced-battery";
            performance = "throughput-performance";
            power-saver = "laptop-battery-powersave";
          };
        };
      };
    };
  };
}
