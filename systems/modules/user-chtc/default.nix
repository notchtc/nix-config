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

  users.users.root.hashedPassword = "!";
}
