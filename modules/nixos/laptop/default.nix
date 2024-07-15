{ inputs, flake, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    flake.nixosModules.desktop
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
      PLATFORM_PROFILE_ON_AC = "performance";
    };
  };
}
