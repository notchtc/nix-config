{ config, lib, ... }:
{
  options.mama.system.keyMap = lib.mkOption {
    type = lib.types.str;
    default = "pl";
    description = "Your keymap";
  };

  config = {
    time.timeZone = if config.mama.profiles.server.enable then "UTC" else "Europe/Warsaw";
    i18n =
      let
        defaultLocale = "en_US.UTF-8";
        pl = "pl_PL.UTF-8";
      in
      {
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
