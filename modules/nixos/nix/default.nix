{ self, inputs, ... }:
{
  imports = [ inputs.lix-module.nixosModules.default ];

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [ self.overlays.default ];
  };

  nix = {
    registry = {
      home-manager.flake = inputs.home;
      nixpkgs.flake = inputs.nixpkgs;
      self.flake = inputs.self;
    };

    optimise.automatic = true;

    channel.enable = false;

    settings = {
      use-xdg-base-directories = true;

      nix-path = "nixpkgs=flake:nixpkgs";

      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "flakes"
        "nix-command"
      ];

      max-jobs = "auto";

      trusted-users = [
        "root"
        "chtc"
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
