{ inputs, ... }:
{
  imports = [ inputs.run0-sudo-shim.result.nixosModules.default ];
  security = {
    wrappers.su.enable = false;
    run0-sudo-shim.enable = true;
  };
}
