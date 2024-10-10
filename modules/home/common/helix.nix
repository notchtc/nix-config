{
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = lib.attrValues { inherit (pkgs) marksman nixd wl-clipboard; };

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
      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          config = {
            nixpkgs.expr = "import (builtins.getFlake \"${inputs.self}\").inputs.nixpkgs {}";
            formatting.command = [ "nixfmt" ];
            options.nixos.expr = "(builtins.getFlake \"${inputs.self}\").nixosConfigurations.${osConfig.networking.hostName}.options";
          };
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nixd" ];
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
      ];
    };
  };
}
