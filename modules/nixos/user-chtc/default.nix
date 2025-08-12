{ config, ... }:
{
  age.secrets.chtc-password.file = ../../../secrets/chtc-password.age;
  users = {
    mutableUsers = false;
    users = {
      chtc = {
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
      root.hashedPassword = "!";
    };
  };
}
