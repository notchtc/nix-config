{
  description = "chtc's nix config";
  nixConfig.commit-lockfile-summary = "chore: bump flakes";

  outputs = inputs:
    inputs.parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [./modules/parts ./overlays ./hosts ./users];
    };

  inputs = {
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    disko.url = "github:nix-community/disko";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home.url = "github:nix-community/home-manager";
    parts.url = "github:hercules-ci/flake-parts";
    plasma-manager.url = "github:pjones/plasma-manager";
    nur.url = "github:nix-community/NUR";

    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/release-23.11";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs.follows = "unstable";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home";
  };
}
