{
  config,
  homeModules,
  lib,
  ...
}:
{
  age.secrets.chtc-password.file = ../../../secrets/chtc-password.age;
  users = {
    mutableUsers = false;
    users.chtc = {
      isNormalUser = true;
      hashedPasswordFile = config.age.secrets.chtc-password.path;

      extraGroups = [
        "audio"
        "gamemode"
        "networkmanager"
        "wheel"
        "video"
      ];
    };
  };

  home-manager.users.chtc = {
    imports = [ homeModules.common ] ++ lib.optionals config.xdg.portal.enable [ homeModules.desktop ];

    programs.git = {
      userName = "chtc";
      userEmail = "chtc@tuta.io";
    };
  };
}
