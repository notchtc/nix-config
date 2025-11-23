{ project, system, ... }:
{
  imports = [ project.inputs.home-manager.result.nixosModules.default ];

  home-manager = {
    backupFileExtension = "backup";
    overwriteBackup = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit (project) inputs packages;
      inherit system;
    };

    sharedModules = [ ../home ];
  };
}
