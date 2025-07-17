{
  project,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ project.inputs.niri.result.nixosModules.niri ];
  nixpkgs.overlays = [ project.inputs.niri.result.overlays.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  environment.systemPackages = lib.attrValues {
    inherit (pkgs) cage wl-clipboard xwayland-satellite-unstable;
  };

  services = {
    devmon.enable = true;
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

  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    hyprlock = { };
  };
}
