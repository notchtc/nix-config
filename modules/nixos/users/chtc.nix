{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ "${inputs.agenix.result}/modules/age.nix" ];
  age.secrets.chtc-password.file = ../../../secrets/chtc-password.age;

  users.users.chtc = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.chtc-password.path;

    extraGroups = [
      "networkmanager"
      "wheel"
    ]
    ++ lib.optionals config.programs.gamemode.enable [ "gamemode" ]
    ++ lib.optionals config.services.pipewire.enable [ "pipewire" ];
  };

  home-manager.users.chtc = {
    programs.git = {
      userEmail = "chtc@tuta.io";
      userName = "chtc";
    };
  };
}
