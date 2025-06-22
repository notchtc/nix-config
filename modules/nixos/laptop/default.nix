{ project, ... }:
{
  imports = [
    "${project.inputs.nixos-hardware.result}/common/pc/laptop"
  ];

  services = {
    power-profiles-daemon.enable = false;
    thermald.enable = true;
    tlp.settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
    };
  };
}
