{
  project,
  lib,
  system,
  ...
}:
{
  imports = [
    (import "${project.inputs.lix-module.result}/module.nix" { lix = project.inputs.lix.src; })
  ];

  nix = {
    channel.enable = false;
    optimise.automatic = true;
    nixPath = [ "/etc/nix/inputs" ];

    settings = {
      use-xdg-base-directories = true;
      trusted-users = [ "@wheel" ];

      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
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

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment = {
    etc = lib.mapAttrs' (name: value: {
      name = "nix/inputs/${name}";
      value.source =
        if
          (lib.strings.isStringLike value.result)
          && (lib.strings.hasPrefix builtins.storeDir (builtins.toString value.result))
        then
          builtins.storePath value.result
        else
          builtins.storePath value.src;
    }) project.inputs;
    systemPackages = [
      project.inputs.nilla-cli.result.packages.nilla-cli.result.${system}
      project.inputs.nilla-home.result.packages.nilla-home.result.${system}
      project.inputs.nilla-nixos.result.packages.nilla-nixos.result.${system}
    ];
  };

  system = {
    stateVersion = "24.11";
  };
}
