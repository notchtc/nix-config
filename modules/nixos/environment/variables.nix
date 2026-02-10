{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) getExe;
in
{
  environment.variables =
    with pkgs;
    {
      EDITOR = getExe nvi;
      SYSTEMD_EDITOR = getExe nvi;

      PAGER = getExe moor;
      MANPAGER = getExe moor;
    }
    // lib.optionalAttrs config.mama.profiles.graphical.enable {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      NIXOS_OZONE_WL = 1;
    };
}
