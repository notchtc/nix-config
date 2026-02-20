{ inputs, ... }:
{
  imports = [ inputs.autoaspm.result.nixosModules.default ];
  services.autoaspm.enable = true;
}
