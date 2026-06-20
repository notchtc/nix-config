{
  config.modules.nixos.locale =
    { config, lib, ... }:
    let
      inherit (lib.modules) mkIf;
      defaultLocale = "en_US.UTF-8";
      pl = "pl_PL.UTF-8";
    in
    {
      console.keyMap = "pl";
      time.timeZone = mkIf config.xdg.portal.enable "Europe/Warsaw";

      i18n = {
        inherit defaultLocale;
        extraLocaleSettings = {
          LANG = defaultLocale;
          LC_COLLATE = defaultLocale;
          LC_CTYPE = defaultLocale;
          LC_MESSAGES = defaultLocale;

          LC_ADDRESS = pl;
          LC_IDENTIFICATION = pl;
          LC_MEASUREMENT = pl;
          LC_MONETARY = pl;
          LC_NAME = pl;
          LC_NUMERIC = pl;
          LC_PAPER = pl;
          LC_TELEPHONE = pl;
          LC_TIME = pl;
        };
      };
    };
}
