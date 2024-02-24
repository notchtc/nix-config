<div align="center">

# [NixOS](https://nixos.org) config

![NixOS](https://nixos.org/logo/nixos-hires.png)

[![NixOS unstable](https://img.shields.io/badge/NixOS-unstable-informational?style=plastic.svg)](https://github.com/nixos/nixpkgs)
[![nix-config flake check](https://github.com/notchtc/nix-config/workflows/nix-config%20flake%20check/badge.svg)](https://github.com/notchtc/nix-config/actions?query=workflow:"nix-config+flake+check")
[![nix-config statix check](https://github.com/notchtc/nix-config/workflows/nix-config%20statix%20check/badge.svg)](https://github.com/notchtc/nix-config/actions?query=workflow:"nix-config+statix+check")
[![nix-config format check](https://github.com/notchtc/nix-config/workflows/nix-config%20format%20check/badge.svg)](https://github.com/notchtc/nix-config/actions?query=workflow:"nix-config+format+check")

This repoitory contains my configuration for NixOS and other software that I use.

</div>

## Description
> [!IMPORTANT]
> As this is my personal configuration, not everything may work for you. You probably also want to change some things around. You're better off creating your own configuration.

NixOS configuration using [flakes](https://nixos.wiki/wiki/Flakes) and [home-manager](https://github.com/nix-community/home-manager).

Other things used:
+ [disko](https://github.com/nix-community/disko)
+ [flake-parts](https://flake.parts)
+ [nur](https://github.com/nix-community/NUR)
+ [nyx](https://github.com/chaotic-cx/nyx)

Configurations that I ""learned"" from:
+ [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
+ [javacafe01/nix-config](https://github.com/javacafe01/nix-config)
+ [moni-dz/nix-config](https://github.com/moni-dz/nix-config)

## Hosts & users
| Host    | Purpose              | User | Purpose   |
|---------|----------------------|------|-----------|
| dorothy | main device (laptop) | chtc | main user |
