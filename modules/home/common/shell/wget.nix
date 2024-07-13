{ config, ... }:
{
  home.sessionVariables = {
    WGETRC = "${config.xdg.configHome}/wgetrc";
  };

  xdg = {
    configFIle = {
      "wgetrc" = {
        enable = true;
        text = ''
          hsts-file \= ${config.xdg.cacheHome}/wget-hsts
        '';
      };
    };
  };
}
