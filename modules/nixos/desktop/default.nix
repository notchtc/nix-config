{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
    ./pipewire.nix
    ./stylix.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  hardware.amdgpu.legacySupport.enable = true;
  time.timeZone = "Europe/Warsaw";

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
