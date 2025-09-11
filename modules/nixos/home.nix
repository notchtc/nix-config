{ inputs, ... }:
{
  imports = [ inputs.home-manager.result.nixosModules.default ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    sharedModules = [ ../home ];
  };
}
