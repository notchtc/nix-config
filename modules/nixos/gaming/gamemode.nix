{ config, lib, ... }:
{
  programs.gamemode = lib.mkIf config.mama.programs.gaming.gamemode.enable {
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
}
