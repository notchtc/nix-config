{
  config.modules.nixos.home = { inputs, ... }: {
    imports = [ inputs.hjem.result.nixosModules.default ];

    hjem = {
      clobberByDefault = true;
      extraModules = [ inputs.noctalia.result.hjemModules.default ];
    };
  };
}
