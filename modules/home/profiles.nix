{ osConfig, ... }:
let
  cfg = osConfig.mama;
in
{
  mama = {
    inherit (cfg) desktop;
    profiles = {
      inherit (cfg.profiles) graphical laptop server;
      gaming = { inherit (cfg.profiles.gaming) enable; };
    };
  };
}
