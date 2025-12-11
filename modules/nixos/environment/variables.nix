{ lib, pkgs, ... }:
let
  inherit (lib) getExe;
in
{
  environment.variables = with pkgs; {
    EDITOR = getExe nvi;
    SYSTEMD_EDITOR = getExe nvi;

    PAGER = getExe moor;
    MANPAGER = getExe moor;
  };
}
