{ config, lib, ... }:
{
  users.users.chtc = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.chtc-password.path;

    extraGroups = [
      "networkmanager"
      "wheel"
    ]
    ++ lib.optionals config.programs.gamemode.enable [ "gamemode" ]
    ++ lib.optionals config.services.pipewire.enable [ "pipewire" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtYPqw1VitvlRnvnO5skoX7vd+N6GET5XrFH4n3jNn3"
    ];
  };

  home-manager.users.chtc = {
    programs.git = {
      userEmail = "chtc@tuta.io";
      userName = "chtc";
    };
  };
}
