{ inputs, ... }:
{
  imports = [ inputs.run0-sudo-shim.result.nixosModules.default ];
  security.run0-sudo-shim.enable = true;
}
