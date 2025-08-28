{ config, pkgs, ... }:
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
  networking.stevenblack.enable = true;
  nix.daemonCPUSchedPolicy = "idle";

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland,xcb";
    SDL_VIDEODRIVER = "wayland";
  };

  programs = {
    nix-ld.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services = {
    journald.extraConfig = ''
      SystemMaxUse=100M
      RuntimeMaxUse=50M
      SystemMaxFileUse=50M
    '';

    xserver = {
      autoRepeatDelay = 480;
      autoRepeatInterval = 40;
      xkb = {
        layout = config.console.keyMap;
        options = "caps:swapescape";
      };
    };
  };

  fonts = {
    packages = [
      pkgs.corefonts
      pkgs.nerd-fonts.symbols-only
    ];
    enableDefaultPackages = true;
  };
}
