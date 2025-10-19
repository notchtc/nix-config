{ osConfig, ... }:
let
  cfg = osConfig.mama;
in
{
  mama = {
    profiles = {
      inherit (cfg.profiles) graphical laptop server;
      gaming = { inherit (cfg.profiles.gaming) enable; };
    };
    desktops = { inherit (cfg.desktops) gnome plasma; };
  };
}
