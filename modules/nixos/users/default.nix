{
  config,
  lib,
  pkgs,
  project,
  ...
}:
{
  imports = [
    "${project.inputs.agenix.result}/modules/age.nix"
    ./chtc.nix
  ];
  age.secrets.chtc-password.file = ../../../secrets/chtc-password.age;

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };

  services.userborn = {
    enable = true;
    passwordFilesLocation = lib.mkIf config.mama.system.ephemeral.enable "/persist/etc/";
  };
}
