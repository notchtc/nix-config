{ inputs, ... }:
{
  imports = [
    "${inputs.nixos-hardware.result}/common/cpu/intel/skylake"
    "${inputs.nixos-hardware.result}/common/gpu/amd"
    "${inputs.nixos-hardware.result}/common/pc/laptop"

    ./disko.nix
  ];

  mama = {
    profiles = {
      graphical.enable = true;
      laptop.enable = true;
    };
    desktops.niri.enable = true;
    programs.gaming.enable = true;
    system.ephemeral.enable = true;
  };

  home-manager.users.chtc = {
    mama.programs.foot.enable = true;
  };

  boot = {
    initrd.kernelModules = [ "dm-snapshot" ];
    kernelModules = [ "kvm-intel" ];
  };

  services = {
    undervolt = {
      enable = true;
      coreOffset = -119;
    };
    displayManager.autoLogin.user = "chtc";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.11";
}
