{
  config,
  flake,
  pkgs,
  lib,
  ...
}:
{
  users.users.chtc = {
    isNormalUser = true;
    initialPassword = "changeme";

    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ];

    packages =
      with pkgs;
      lib.optionals config.services.desktopManager.plasma6.enable [
        gimp
        keepassxc
        lutris
        nicotine-plus
        picard
        plugdata
        qbittorrent
        telegram-desktop
        vesktop
      ];
  };

  users.users.root.hashedPassword = "!";

  nix.settings.trusted-users = [ "chtc" ];
  programs.nh.flake = "/home/chtc/.config/nix-config";

  home-manager.users.chtc = {
    imports = [
      flake.homeModules.common
    ] ++ lib.optionals config.services.desktopManager.plasma6.enable [ flake.homeModules.desktop ];

    programs.git = {
      userName = "chtc";
      userEmail = "chtc@tuta.io";
    };
  };
}
