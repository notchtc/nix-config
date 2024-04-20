{ pkgs, ... }:
let
  name = "chtc";
in
{
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;

    users.${name} = {
      isNormalUser = true;
      initialPassword = "changeme";
      home = "/home/${name}";

      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
      ];
    };

    users.root.hashedPassword = "!";
  };

  programs.nh.flake = "/home/${name}/.config/nix-config";
}
