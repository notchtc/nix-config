# NixOS modules
Every module in this list can be used as a nixosModule.

- [common](common.nix) - base configuration
- core
  - [boot](core/boot.nix) - configuration for the bootloader
  - [security](core/security.nix) - security related configuration
  - [user-chtc](core/user-chtc.nix) - creating an user called `chtc`
- desktops
  - [gnome](desktops/gnome.nix) - gnome environment
  - [plasma](desktops/plasma.nix) - plasma environment
- hardware
  - [amdgpu](hardware/amdgpu.nix) - use amdgpu driver on all amd gpus
  - [opengl](hardware/opengl.nix) - graphics & hardware acceleration related configuration
- [networking](networking/default.nix)
- [nix](nix/default.nix)
  - [nh](nix/nh.nix) - configuration for [nh](https://github.com/viperML/nh)
  - [nixpkgs](nix/nixpkgs.nix) - nixpkgs configuration
  - [substituters](nix/substituters.nix) - binary cache
- programs
  - [gamemode](programs/gamemode.nix) - configuration for gamemode
  - [steam](programs/steam.nix) - steam + proton-ge
- services
  - [pipewire](programs/pipewire.nix) - enable pipewire
  - [power](programs/power.nix) - power management
