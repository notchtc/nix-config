{pkgs, ...}: {
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;

    users.chtc = {
      isNormalUser = true;
      initialPassword = "changeme";
      home = "/home/chtc";

      extraGroups = ["wheel" "networkmanager" "audio" "video"];
    };

    users.root.hashedPassword = "!";
  };
}
