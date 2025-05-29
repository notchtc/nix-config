{ pkgs, ... }:
{
  imports = [
    ../common
    ./gnome.nix
    ./pipewire.nix
    ./stylix.nix
  ];

  isDesktop = true;
  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  time.timeZone = "Europe/Warsaw";

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
