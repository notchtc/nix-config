{
  config,
  pkgs,
  project,
  system,
  ...
}:
{
  environment = {
    systemPackages = [
      project.inputs.nilla-cli.result.packages.default.result.${system}
      project.inputs.nilla-nixos.result.packages.default.result.${system}
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
