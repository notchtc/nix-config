{ lib, ... }:
{
  options = {
    isDesktop = lib.mkEnableOption "Mark the host as a desktop";
  };
}
