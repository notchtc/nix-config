{ config }:
let
  inherit (config.modules) home nixos;

  base = [
    nixos.autoaspm
    nixos.boot
    nixos.documentation
    nixos.home
    nixos.journald
    nixos.kernel
    nixos.keyd
    nixos.ld
    nixos.locale
    nixos.logrotate
    nixos.mineral
    nixos.modern
    nixos.moor
    nixos.networking
    nixos.nix
    nixos.ntpd-rs
    nixos.oom
    nixos.packages
    nixos.run0
    nixos.scx
    nixos.secrets
    nixos.ssh
    nixos.tmp
    nixos.user-chtc
    nixos.zfs
    nixos.zram
    nixos.zsh
  ];

  base-home = [
    home.helix
    home.jujutsu
    home.use-xdg-dirs
  ];

  desktop = base ++ [
    "${config.inputs.srvos.result}/nixos/desktop"

    nixos.audio
    nixos.bluetooth
    nixos.dms
    nixos.fonts
    nixos.kmscon
    nixos.librewolf
    nixos.niri
    nixos.plymouth
    nixos.theming
    nixos.video
    nixos.xdg-portals
  ];

  desktop-home = base-home ++ [
    home.discord
    home.dolphin
    home.ghostty
    home.media
    home.qbittorrent
    home.telegram
  ];
in
{
  config.systems.nixos = {
    elisabeth = {
      pkgs = config.inputs.nixpkgs.result.x86_64-linux;

      modules = desktop ++ [
        nixos.cpu-amd
        nixos.gaming
        nixos.gpu-nvidia
        nixos.laptop

        { hjem.extraModules = desktop-home; }

        ./elisabeth
      ];

      args = { inherit (config) inputs modules; };
    };
  };
}
