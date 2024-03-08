{inputs, ...}: {
  imports = [
    inputs.nh.nixosModules.default
  ];

  environment.sessionVariables.FLAKE = "/home/chtc/.config/nix-config";

  nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 3";
    };
  };
}
