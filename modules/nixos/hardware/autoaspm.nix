{
  config,
  lib,
  project,
  ...
}:
{
  imports = [ project.inputs.autoaspm.result.nixosModules.default ];

  options.mama.hardware.autoaspm = lib.mkEnableOption "Automatically activate ASPM on all supported devices";

  config.services.autoaspm.enable = lib.mkIf config.mama.hardware.autoaspm true;
}
