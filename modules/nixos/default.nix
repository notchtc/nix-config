{
  flake.nixosModules = {
    common = import ./common.nix;
    user-chtc = import ./core/user-chtc.nix;
    gnome = import ./desktops/gnome.nix;
    plasma5 = import ./desktops/plasma5.nix;
    plasma6 = import ./desktops/plasma6.nix;
    opengl = import ./hardware/opengl.nix;
    fonts = import ./programs/fonts.nix;
    gamemode = import ./programs/gamemode.nix;
    steam = import ./programs/steam.nix;
    pipewire = import ./services/pipewire.nix;
    power = import ./services/power.nix;
  };
}
