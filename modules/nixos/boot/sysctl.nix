{ config, lib, ... }:
{
  boot.kernel.sysctl = {
    "vm.dirty_bytes" = 268435456;
    "vm.dirty_background_bytes" = 134217728;
    "vm.max_map_count" = 2147483642;
  }
  // lib.optionalAttrs config.mama.profiles.gaming.enable { "kernel.split_lock_mitigate" = 0; };
}
