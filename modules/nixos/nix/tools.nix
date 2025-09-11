{ inputs, pkgs, ... }:
{
  environment = {
    systemPackages = [
      inputs.nilla-cli.result.packages.default.result.${pkgs.system}
      inputs.nilla-utils.result.packages.default.result.${pkgs.system}
    ];
  };

  system = {
    disableInstallerTools = true;
    tools.nixos-rebuild.enable = true;
  };
}
