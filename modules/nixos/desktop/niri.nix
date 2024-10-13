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
      playerctl
      swaybg
      ;

    xwayland-satellite = pkgs.xwayland-satellite.overrideAttrs (oldAttrs: {
      buildFeatures = [ "systemd" ];
    });
  };

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  services.greetd =
    let
      tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
      session = "${pkgs.niri}/bin/niri-session";
    in
    {
      enable = true;
      settings = {
        initial_session = {
          command = "${session}";
          user = "${config.services.displayManager.autoLogin.user}";
        };
        default_session = {
          command = "${tuigreet} -c ${session} -g 'Welcome to NixOS!' -t -r --remember-user-session --user-menu";
          user = "greeter";
        };
      };
    };
}
