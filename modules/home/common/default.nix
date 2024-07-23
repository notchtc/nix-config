{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nur.hmModules.nur
    inputs.chaotic.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
    ./git.nix
    ./helix.nix
    ./xdg.nix
  ];

  home = {
    packages = with pkgs; [ trash-cli ];
    sessionVariables = {
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      WGETRC = "${config.xdg.configHome}/wgetrc";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
    };

    stateVersion = "24.05";
  };

  programs = {
    command-not-found.enable = false;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;

    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
  };

  xdg = {
    configFile = {
      "wgetrc" = {
        enable = true;
        text = ''
          hsts-file \= ${config.xdg.cacheHome}/wget-hsts
        '';
      };
    };
  };
}
