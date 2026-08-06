{
  config.modules.nixos.memory = {
    zramSwap = {
      enable = true;
      memoryPercent = 100;
    };
  };
}
