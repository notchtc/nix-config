{ config, lib, ... }:
let
  inherit (lib) mkIf;
  laptop = config.mama.profiles.laptop.enable;
in
{
  config = mkIf laptop {
    boot.kernelParams = [ "rcutree.enable_rcu_lazy=1" ];

    services = {
      power-profiles-daemon.enable = false;
      tlp.enable = false;
      tuned = {
        enable = true;
        settings.dynamic_tuning = true;
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
