{
  config.modules.nixos.kmscon =
    { config, lib, ... }:
    let
      inherit (lib.attrsets) optionalAttrs;
    in
    {
      console.enable = false;
      services.kmscon = {
        enable = true;
        config = {
          xkb-layout = config.console.keyMap;
        }
        // optionalAttrs config.xdg.portal.enable {
          font-name = "Atkinson Hyperlegible Mono";
          hwaccel = true;
        };
      };
    };
}
