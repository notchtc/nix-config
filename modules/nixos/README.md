# NixOS modules
Every module in this list can be used as a nixosModule.

- [common](common.nix) - base configuration
- core
  - [boot](core/boot.nix) - configuration for the bootloader
  - [security](core/security.nix) - security related configuration
  - [user-chtc](core/user-chtc.nix) - creating an user called `chtc`
- desktops
  - [gnome](desktops/gnome.nix) - gnome environment
  - [plasma5](desktops/plasma5.nix) - plasma 5 environment
  - [plasma6](desktops/plasma6.nix) - plasma 6 environment
- hardware
  - [opengl](hardware/opengl.nix) - graphics & hardware acceleration related configuration
- [nix](nix/default.nix)
  - [nh](nix/nh.nix) - configuration for [nh](https://github.com/viperML/nh)
  - [nixpkgs](nix/nixpkgs.nix) - nixpkgs configuration
  - [substituters](nix/substituters.nix) - binary cache
- [networking](networking/default.nix)
- programs
  - [gamemode](programs/gamemode.nix) - configuration for gamemode
  - [steam](programs/steam.nix) - steam + proton-ge
- services
  - [pipewire](programs/pipewire.nix) - enable pipewire
  - [power](programs/power.nix) - power management
