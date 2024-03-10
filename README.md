<div align="center">

# [NixOS](https://nixos.org) config

![NixOS](https://nixos.org/logo/nixos-hires.png)

[![NixOS unstable](https://img.shields.io/badge/NixOS-unstable-informational?style=plastic.svg)](https://github.com/nixos/nixpkgs)
[![nix-config flake check](https://github.com/notchtc/nix-config/workflows/nix-config%20flake%20check/badge.svg)](https://github.com/notchtc/nix-config/actions?query=workflow:"nix-config+flake+check")
[![nix-config statix check](https://github.com/notchtc/nix-config/workflows/nix-config%20statix%20check/badge.svg)](https://github.com/notchtc/nix-config/actions?query=workflow:"nix-config+statix+check")
[![nix-config format check](https://github.com/notchtc/nix-config/workflows/nix-config%20format%20check/badge.svg)](https://github.com/notchtc/nix-config/actions?query=workflow:"nix-config+format+check")

This repository contains my configuration for NixOS and other software that I use.

</div>

## Description
> [!IMPORTANT]
> As this is my personal configuration, not everything may work for you. You probably also want to change some things around. You're better off creating your own configuration.

NixOS configuration using [flakes](https://nixos.wiki/wiki/Flakes) and [home-manager](https://github.com/nix-community/home-manager).

Flakes used:
- [disko](https://github.com/nix-community/disko)
- [flake-parts](https://flake.parts)
- [plasma-manager](https://github.com/pjones/plasma-manager)
- [nh](https://github.com/viperML/nh)
- [nix-index-database](https://github.com/Mic92/nix-index-database)
- [nur](https://github.com/nix-community/NUR)
- [nyx](https://github.com/chaotic-cx/nyx)

## Structure
- [modules](modules) - common parts of NixOS and home-manager configuration
- [hosts](hosts) - NixOS configurations
- [users](users) - home-manager configurations
- [overlays](overlays) - packages

## Resources
Other configurations from where I learned and copied:
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [javacafe01/nix-config](https://github.com/javacafe01/nix-config)
- [moni-dz/nix-config](https://github.com/moni-dz/nix-config)
- [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [viperML/dotfiles](https://github.com/viperML/dotfiles)
