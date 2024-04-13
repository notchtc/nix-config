{
  flake.nixosModules = {
    common = import ./common.nix;
    boot = import ./core/boot.nix;
    networking = import ./networking;
    security = import ./core/security.nix;
    user-chtc = import ./core/user-chtc.nix;
    gnome = import ./desktops/gnome.nix;
    plasma = import ./desktops/plasma.nix;
    opengl = import ./hardware/opengl.nix;
    nix = import ./nix;
    ananicy = import ./programs/ananicy.nix;
    gamemode = import ./programs/gamemode.nix;
    steam = import ./programs/steam.nix;
    pipewire = import ./services/pipewire.nix;
    power = import ./services/power.nix;
  };
}
