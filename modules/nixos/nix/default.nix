{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./nixpkgs.nix
    ./nh.nix
    ./substituters.nix
  ];

  nix = {
    registry = lib.mapAttrs (_: v: { flake = v; }) inputs;

    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    optimise.automatic = true;

    settings = lib.mkMerge [
      {
        use-xdg-base-directories = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "ca-derivations"
          "auto-allocate-uids"
        ];
        max-jobs = "auto";

        trusted-users = [ "@wheel" ];
      }
    ];
  };
}
