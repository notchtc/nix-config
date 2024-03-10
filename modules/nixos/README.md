# NixOS modules
Every module can be used as a nixosModule unless noted.

- [common](common.nix) - base configuration
- core
  - [boot](core/boot.nix)[^1] - configuration for the bootloader
  - [security](core/security.nix)[^1] - security related configuration
  - [user-chtc](core/user-chtc.nix) - creating an user called `chtc`
- desktops
  - [gnome](desktops/gnome.nix) - gnome environment
  - [plasma5](desktops/plasma5.nix) - plasma 5 environment
  - [plasma6](desktops/plasma6.nix) - plasma 6 environment
- hardware
  - [opengl](hardware/opengl.nix) - graphics & hardware acceleration related configuration
- networking[^1]
- nix[^1]
  - [nh](nix/nh.nix) - configuration for [nh](https://github.com/viperML/nh)
  - [nixpkgs](nix/nixpkgs.nix) - nixpkgs configuration
  - [substituters](nix/substituters.nix) - binary cache
- programs
  - [fonts](programs/fonts.nix) - font configuration
  - [gamemode](programs/gamemode.nix) - configuration for gamemode
  - [steam](programs/steam.nix) - steam + proton-ge
- services
  - [pipewire](programs/pipewire.nix) - enable pipewire
  - [power](programs/power.nix) - power management

  [^1]: can't be used as a nixosModule, is used in [common](common.nix)
