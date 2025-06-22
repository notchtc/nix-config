{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
    ./pipewire.nix
    ./stylix.nix
  ];

  isDesktop = true;
  hardware.amdgpu.legacySupport.enable = true;
  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  time.timeZone = "Europe/Warsaw";

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
