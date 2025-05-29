{ config, lib, ... }:
{
  users.users.chtc = {
    isNormalUser = true;
    initialPassword = "changeme";

    extraGroups = [
      "audio"
      "gamemode"
      "networkmanager"
      "wheel"
      "video"
    ];
  };

  home-manager.users.chtc =
    { ... }:
    {
      imports =
        [
          ../../home/common
        ]
        ++ lib.optionals config.isDesktop [
          ../../home/desktop
        ];
    };

  users.users.root.hashedPassword = "!";
}
