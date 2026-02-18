{ pkgs, ... }:
{
  system.preSwitchChecks.diff = ''
    incoming="''${1-}"
    if [[ -e /run/current-system && -e "''${incoming-}" ]]; then
      echo "=== diff to current-system"
      ${pkgs.dix}/bin/dix /run/current-system "''${incoming-}"
      echo "=== end of diff"
    fi
  '';
}
