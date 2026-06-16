{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.run0-sudo-shim.result.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  security = {
    polkit.enable = true;
    sudo.enable = false;
    wrappers.su.enable = false;
  };
}
