{ inputs, ... }:
{
  imports = [
    inputs.lix-module.nixosModules.default
    ./nh.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    registry = {
      home-manager.flake = inputs.home-manager;
      nixpkgs.flake = inputs.nixpkgs;
    };

    optimise.automatic = true;

    channel.enable = false;

    settings = {
      nix-path = "nixpkgs=flake:nixpkgs";

      max-jobs = "auto";

      use-xdg-base-directories = true;

      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "flakes"
        "nix-command"
      ];

      substituters = [
        "https://cache.lix.systems"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
