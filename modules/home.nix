{
  config.modules.nixos.home = { inputs, ... }: {
    imports = [ inputs.hjem.result.nixosModules.default ];

    hjem = {
      clobberByDefault = true;
      extraModules = [ inputs.hjem-rum.result.hjemModules.hjem-rum ];
    };
  };
}
