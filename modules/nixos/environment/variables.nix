{ lib, pkgs, ... }:
let
  inherit (lib) getExe getExe';
in
{
  environment.variables = with pkgs; {
    EDITOR = getExe' busybox "vi";
    SYSTEMD_EDITOR = getExe' busybox "vi";

    PAGER = getExe moor;
    MANPAGER = getExe moor;
  };
}
