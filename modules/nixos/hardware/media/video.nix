{ config, lib, ... }:
let
  inherit (lib) mkIf;
  graphical = config.mama.profiles.graphical.enable;
in
{
  config.hardware.graphics = mkIf graphical {
    enable = true;
    enable32Bit = true;
  };
}
