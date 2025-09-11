{ osConfig, ... }:
let
  cfg = osConfig.mama;
in
{
  mama = {
    profiles = { inherit (cfg.profiles) graphical laptop server; };
    desktops = { inherit (cfg.desktops) gnome niri; };
  };
}
