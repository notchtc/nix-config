{lib, ...}: {
  imports = [
    ../../modules/nixos/desktops/plasma.nix
    ../../modules/nixos/hardware/opengl.nix
    ../../modules/nixos/programs/gamemode.nix
    ../../modules/nixos/programs/steam.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/power.nix
    ./hardware-configuration.nix
    ./disko.nix
  ];

  boot = {
    kernelParams = ["radeon.si_support=0" "radeon.cik_support=0" "amdgpu.si_support=1" "amdgpu.cik_support=1"];
    kernelModules = ["i915" "amdgpu"];
  };

  networking.hostName = "dorothy";

  systemd.services.ModemManager.enable = lib.mkForce false;

  system.stateVersion = "23.11";
}
