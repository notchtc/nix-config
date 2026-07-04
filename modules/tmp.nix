{
  config.modules.nixos.tmp = {
    boot.tmp = {
      useTmpfs = true;
      tmpfsHugeMemoryPages = "within_size";
    };
  };
}
