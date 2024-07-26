{ pkgs, ... }:
{
  imports = [
    ./ananicy.nix
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    melonDS
    ppsspp-sdl-wayland
  ];
}
