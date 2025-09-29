{
  config,
  lib,
  project,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkOption;
  cfg = config.mama.system.ephemeral;
in
{
  imports = [ "${project.inputs.preservation.result}/module.nix" ];

  options.mama.system.ephemeral = {
    enable = mkEnableOption ''
      Rollback / to a pristine state.
    '';

    extraDirectories = mkOption {
      default = [ ];
      description = ''
        Additional directories to persist.
      '';
    };

    extraFiles = mkOption {
      default = [ ];
      description = ''
        Additional files to persist.
      '';
    };
  };

  config = mkIf cfg.enable {
    preservation = {
      enable = true;
      preserveAt."/persist" = {
        directories = [ "/etc/NetworkManager/system-connections" ] ++ cfg.extraDirectories;

        files = cfg.extraFiles;

        commonMountOptions = [
          "x-gvfs-hide"
          "x-gdu.hide"
        ];
      };
    };

    age.identityPaths = [
      "/persist/etc/ssh/ssh_host_ed25519_key"
      "/persist/etc/ssh/ssh_host_rsa_key"
    ];

    fileSystems = {
      "/persist".neededForBoot = true;
      "/var/log".neededForBoot = true;
    };
  };
}
