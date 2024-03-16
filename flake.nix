{
  description = "chtc's NixOS and Home Manager configuration";
  nixConfig.commit-lockfile-summary = "chore: bump flakes";

  outputs =
    inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./modules
        ./overlays
        ./hosts
        ./users
      ];

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;
        };
    };

  inputs = {
    disko.url = "github:nix-community/disko";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home.url = "github:nix-community/home-manager";
    parts.url = "github:hercules-ci/flake-parts";
    plasma-manager.url = "github:pjones/plasma-manager";
    nh.url = "github:viperML/nh";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nur.url = "github:nix-community/NUR";

    f-sy-h = {
      url = "github:z-shell/F-Sy-H";
      flake = false;
    };

    zsh-autocomplete = {
      url = "github:marlonrichert/zsh-autocomplete";
      flake = false;
    };

    zsh-nix-shell = {
      url = "github:chisui/zsh-nix-shell";
      flake = false;
    };

    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/release-23.11";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs.follows = "unstable";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home.inputs.nixpkgs.follows = "nixpkgs";
    nh.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home";
    };
  };
}
