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

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    regreet = {
      enable = true;
      cageArgs = [
        "-s"
        "-m"
        "last"
      ];
    };
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
      };
    };
  };

  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    hyprlock = { };
  };
}
