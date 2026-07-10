{
  config.modules.nixos.home = { inputs, ... }: {
    imports = [ inputs.hjem.result.nixosModules.default ];

    hjem = {
      clobberByDefault = true;
      extraModules = [
        inputs.hjem-rum.result.hjemModules.hjem-rum
        inputs.noctalia.result.hjemModules.default
        inputs.qtengine.result.hjemModules.default
      ];
    };
  };
}
