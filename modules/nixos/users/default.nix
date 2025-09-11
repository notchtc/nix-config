{ pkgs, ... }:
{
  imports = [ ./chtc.nix ];

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };

  services.userborn = {
    enable = true;
    passwordFilesLocation = "/persist/etc";
  };
}
