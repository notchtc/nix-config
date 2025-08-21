{ pkgs, ... }:
{
  imports = [
    ./hardening.nix
    ./niri.nix
    ./pipewire.nix
    ./stylix.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  hardware.amdgpu.legacySupport.enable = true;
  time.timeZone = "Europe/Warsaw";

  fonts = {
    packages = [
      pkgs.corefonts
      pkgs.nerd-fonts.symbols-only
    ];
    enableDefaultPackages = true;
  };

  nix.daemonCPUSchedPolicy = "idle";
  programs = {
    nix-ld.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    RuntimeMaxUse=50M
    SystemMaxFileUse=50M
  '';
}
