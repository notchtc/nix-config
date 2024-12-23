{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      brightnessctl
      libnotify
      playerctl
      swaybg
      wl-clipboard
      wayland-utils
      ;
  };

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services = {
    udisks2.enable = true;
    greetd = {
      enable = true;
      settings = {
        initial_session = lib.mkIf config.services.displayManager.autoLogin.enable {
          command = "${pkgs.niri-unstable}/bin/niri-session";
          user = "${config.services.displayManager.autoLogin.user}";
        };
        default_session = {
          command = "${pkgs.cage}/bin/cage -s -m last -- ${pkgs.greetd.gtkgreet}/bin/gtkgreet -c=niri-session";
          user = "greeter";
        };
      };
    };
  };
}
