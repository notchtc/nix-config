{
  flake,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    flake.nixosModules.common
    ./plasma.nix
    ./pipewire.nix
    ./fonts.nix
  ];

  boot = {
    plymouth = {
      enable = true;
      theme = "breeze";
      font = "${pkgs.iosevka}/share/fonts/truetype/Iosevka-Regular.ttf";
    };
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
