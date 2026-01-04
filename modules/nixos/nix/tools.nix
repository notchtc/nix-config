{ inputs, system, ... }:
{
  environment = {
    systemPackages = [
      inputs.nilla-cli.result.packages.default.result.${system}
      inputs.nilla-nixos.result.packages.default.result.${system}
    ];
  };

  system = {
    disableInstallerTools = true;
    tools.nixos-rebuild.enable = true;
  };
}
