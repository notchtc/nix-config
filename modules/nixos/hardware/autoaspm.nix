{
  config,
  lib,
  project,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mama.hardware.autoaspm;
in
{
  imports = [ project.inputs.autoaspm.result.nixosModules.default ];

  options.mama.hardware.autoaspm = mkEnableOption "Automatically activate ASPM on all supported devices";

  config.services.autoaspm.enable = mkIf cfg true;
}
