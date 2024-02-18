{
  description = "chtc's nix config";
  nixConfig.commit-lockfile-summary = "chore: bump flakes";

  outputs = inputs:
    inputs.parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [./modules/parts ./overlays ./hosts ./users];
    };

  inputs = {
    disko.url = "github:nix-community/disko";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home.url = "github:nix-community/home-manager";
    parts.url = "github:hercules-ci/flake-parts";
    plasma-manager.url = "github:pjones/plasma-manager";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nur.url = "github:nix-community/NUR";

    f-sy-h = {
      url = "github:z-shell/F-Sy-H";
      flake = false;
    };

    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
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
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home";
    };
  };
}
