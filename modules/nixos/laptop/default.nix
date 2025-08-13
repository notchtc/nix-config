{ project, ... }:
{
  imports = [ "${project.inputs.nixos-hardware.result}/common/pc/laptop" ];

  services = {
    power-profiles-daemon.enable = false;
    tlp.enable = false;
    tuned.enable = true;
  };
}
