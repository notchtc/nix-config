{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nix;
    settings.use-xdg-base-directories = true;
  };

  programs = {
    gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
      };

      extensions = lib.attrValues {
        inherit
          (pkgs)
          gh-cal
          gh-dash
          gh-eco
          ;
      };
    };

    git = {
      enable = true;
      userName = "chtc";
      userEmail = "chtc@tuta.io";
    };

    home-manager = {
      enable = true;
      path = "${inputs.home}";
    };

    helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "base16_terminal";

        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
      };
    };

    bat = {
      enable = true;
      config = {
        style = "plain";
        theme = "base16";
      };
    };

    eza = {
      enable = true;
      enableAliases = false;
    };

    starship = {
      enable = true;
      settings = import ./config/starship.nix;
    };

    zoxide = {
      enable = true;
    };

    fish = {
      enable = true;
      shellAbbrs = import ./config/shell-aliases.nix;

      interactiveShellInit = ''
        set -U fish_greeting
      '';
    };
  };
}
