{ config, lib, ... }:
let
  inherit (lib) optionals;
in
{
  users.users.chtc = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.chtc-password.path;

    extraGroups = [ "wheel" ] ++ optionals config.services.pipewire.enable [ "pipewire" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtYPqw1VitvlRnvnO5skoX7vd+N6GET5XrFH4n3jNn3"
    ];
  };

  services.displayManager.autoLogin.user = "chtc";
  home-manager.users.chtc = {
    programs.jujutsu.settings.user = {
      email = "chtc@tuta.io";
      name = "chtc";
    };
  };
}
