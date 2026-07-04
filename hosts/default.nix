{ config }:
let
  inherit (builtins) attrValues;
  inherit (config.modules) home nixos;

  base =
    attrValues {
      inherit (nixos)
        autoaspm
        boot
        documentation
        home
        journald
        kernel
        keyd
        ld
        locale
        logrotate
        mineral
        modern
        moor
        networking
        nix
        ntpd-rs
        oom
        packages
        run0
        scx
        secrets
        ssh
        systemd
        tmp
        user
        zfs
        zram
        zsh
        ;
    }
    ++ [ { hjem.extraModules = attrValues { inherit (home) direnv helix jujutsu; }; } ];

  desktop =
    base
    ++ attrValues {
      inherit (nixos)
        audio
        bluetooth
        dms
        dolphin
        fonts
        kmscon
        librewolf
        niri
        plymouth
        theming
        video
        xdg
        ;

      desktop = "${config.inputs.srvos.result}/nixos/desktop";
    }
    ++ [
      {
        hjem.extraModules = attrValues {
          inherit (home)
            discord
            ghostty
            media
            qbittorrent
            telegram
            ;
        };
      }
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

        ./elisabeth
      ];

      args = { inherit (config) inputs modules; };
    };
  };
}
