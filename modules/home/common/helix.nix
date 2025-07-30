{ lib, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = lib.attrValues { inherit (pkgs) markdown-oxide nixd wl-clipboard; };

    settings = {
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
            args = [ "-s" ];
          };
        }
      ];
    };
  };
}
