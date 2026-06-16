{
  config,
  inputs,
  pkgs,
  ...
}:
{

  imports = [ inputs.nix-monitored.result.nixosModules.default ];

  nix.monitored = {
    enable = true;
    package = pkgs.nix-monitored.override { nix = pkgs.lixPackageSets.latest.lix; };
    notify = false;
  };

  nixpkgs.overlays = [ (_: prev: { comma = prev.comma.override { nix = config.nix.package; }; }) ];
}
