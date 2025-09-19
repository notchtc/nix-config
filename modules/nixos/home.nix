{ project, ... }:
{
  imports = [ project.inputs.home-manager.result.nixosModules.default ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit (project) inputs; };

    sharedModules = [ ../home ];
  };
}
