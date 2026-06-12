{ inputs, pkgs, ... }: {
  environment = {
    systemPackages = [
      inputs.nilla-cli.result.packages.default.result.${pkgs.stdenv.hostPlatform.system}
      inputs.nilla-nixos.result.packages.default.result.${pkgs.stdenv.hostPlatform.system}
    ];
  };

  system = {
    disableInstallerTools = true;
    tools.nixos-rebuild.enable = true;
  };
}
