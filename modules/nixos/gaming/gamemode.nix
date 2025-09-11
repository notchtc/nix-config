{ config, lib, ... }:
{
  config = lib.mkIf config.mama.programs.gaming.gamemode.enable {
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 17;
        };
        gpu = {
          apply_gpu_optimizations = "accept-responsibility";
          gpu_device = 0;
        };
      };
    };
  };
}
