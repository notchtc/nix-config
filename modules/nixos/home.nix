{
  config,
  inputs,
  packages,
  ...
}:
{
  imports = [ "${inputs.home-manager.result}/nixos" ];

  home-manager = {
    backupFileExtension = "backup";
    minimal = true;
    overwriteBackup = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs packages;
      inherit (config.mama) profiles;
    };

    sharedModules = [ ../home ];
  };
}
