{ config }:
let
  inherit (builtins) attrValues;
  inherit (config.modules) home nixos;

  base =
    attrValues {
      inherit (nixos)
        autoaspm
        bat
        boot
        documentation
        home
        journald
        kernel
        keyd
        ld
        locale
        logrotate
        memory
        mineral
        modern
        moor
        networking
        nix
        ntpd-rs
        packages
        remove-unneeded
        run0
        scx
        secrets
        shell
        ssh
        systemd
        tmp
        user
        zfs
        ;
    }
    ++ [
      {
        hjem.extraModules = attrValues {
          inherit (home)
            bottom
            direnv
            helix
            jujutsu
            zoxide
            ;
        };
      }
    ];

  desktop =
    base
    ++ attrValues {
      inherit (nixos)
        audio
        bluetooth
        dolphin
        fonts
        kmscon
        librewolf
        niri
        plymouth
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
            keepassxc
            media
            noctalia
            qbittorrent
            telegram
            theming
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
