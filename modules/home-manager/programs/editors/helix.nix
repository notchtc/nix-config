{ lib, pkgs, ... }:
{
  home.packages = lib.attrValues { inherit (pkgs) marksman nil; };

  programs = {
    helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "base16_transparent";

        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
      };
    };
  };
}
