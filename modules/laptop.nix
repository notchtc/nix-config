{
  config.modules.nixos.laptop = {
    boot.kernelParams = [ "rcutree.enable_rcu_lazy=1" ];

    services = {
      power-profiles-daemon.enable = false;
      tlp.enable = false;
      tuned.enable = true;
    };
  };
}
