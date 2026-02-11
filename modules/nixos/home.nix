{
  config,
  inputs,
  packages,
  system,
  ...
}:
{
  imports = [ "${inputs.home-manager.result}/nixos" ];

  home-manager = {
    backupFileExtension = "backup";
    overwriteBackup = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs packages system;
      inherit (config.mama) profiles;
    };

    sharedModules = [ ../home ];
  };
}
