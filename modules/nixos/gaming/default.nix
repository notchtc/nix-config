{ pkgs, ... }:
{
  imports = [
    ./ananicy.nix
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    lime3ds
    melonDS
    ppsspp-sdl-wayland
  ];
}
