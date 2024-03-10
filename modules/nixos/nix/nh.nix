{inputs, ...}: {
  imports = [
    inputs.nh.nixosModules.default
  ];

  nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 1w";
    };
  };
}
