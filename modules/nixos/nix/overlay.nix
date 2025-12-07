{ inputs, system, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      comma = prev.comma.override { nix = final.nix-monitored; };

      nix-monitored = inputs.nix-monitored.result.packages.${system}.default.override {
        nix = final.lixPackageSets.git.lix;
      };
      nixos-rebuild = prev.nixos-rebuild.override { nix = final.nix-monitored; };
    })
  ];
}
