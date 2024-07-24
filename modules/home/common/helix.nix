{ lib, pkgs, ... }:
{

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = lib.attrValues { inherit (pkgs) marksman nil wl-clipboard; };

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
}
