{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    services.greetd = {
      enable = true;
      useTextGreeter = true;

      settings = {
        default_session = {
          user = "greeter";
          command = "${pkgs.tuigreet}/bin/tuigreet -i -t -c ${pkgs.niri}/bin/niri-session";
        };

        initial_session = {
          command = "${pkgs.niri}/bin/niri-session";
          user = "${config.services.displayManager.autoLogin.user}";
        };
      };
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
