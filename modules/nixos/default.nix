{
  flake.nixosModules = {
    common = import ./common.nix;
    boot = import ./core/boot.nix;
    security = import ./core/security.nix;
    user-chtc = import ./core/user-chtc.nix;
    plasma = import ./desktops/plasma.nix;
    amdgpu = import ./hardware/amdgpu.nix;
    graphics = import ./hardware/graphics.nix;
    networking = import ./networking;
    nix = import ./nix;
    nh = import ./nix/nh.nix;
    ananicy = import ./programs/ananicy.nix;
    gamemode = import ./programs/gamemode.nix;
    steam = import ./programs/steam.nix;
    pipewire = import ./services/pipewire.nix;
    power = import ./services/power.nix;
  };
}
