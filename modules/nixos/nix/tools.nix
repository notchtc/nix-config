{
  config,
  inputs,
  pkgs,
  system,
  ...
}:
{
  environment = {
    systemPackages = [
      inputs.nilla-cli.result.packages.default.result.${system}
      inputs.nilla-nixos.result.packages.default.result.${system}
      pkgs.lix-diff
    ];
  };

  system = {
    disableInstallerTools = true;
    tools.nixos-rebuild.enable = true;

    activationScripts.diff = {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "comparing changes..."
          ${pkgs.lix-diff}/bin/lix-diff --lix-bin ${config.nix.package}/bin /run/current-system "$systemConfig"
        fi
      '';
    };
  };
}
