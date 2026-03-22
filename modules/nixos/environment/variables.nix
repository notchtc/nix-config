{ config, lib, ... }:
{
  environment.variables = {
    PAGER = "moor";
    MANPAGER = "moor";
  }
  // lib.optionalAttrs config.mama.profiles.graphical.enable {
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    NIXOS_OZONE_WL = 1;
  };
}
