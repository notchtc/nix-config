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

  nix.settings.trusted-users = [ "chtc" ];
  programs.nh.flake = "/home/chtc/.config/nix-config";
}
