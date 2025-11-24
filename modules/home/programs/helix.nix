{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = lib.attrValues { inherit (pkgs) markdown-oxide nixd nixfmt; };
    settings = {
      theme = "solarized_dark";
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          character = "╎";
          render = true;
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
        };

        bufferline = "multiple";
        line-number = "relative";
        soft-wrap.enable = true;
      };

      keys = {
        normal = {
          "A-x" = "extend_to_line_bounds";
          "X" = "select_line_above";
          "A-l" = ":lsp-workspace-command";
        };

        select = {
          "A-x" = "extend_to_line_bounds";
          "X" = "select_line_above";
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
        #{
        #  name = "typst";
        #  auto-format = true;
        #  formatter.command = "${pkgs.typstyle}/bin/typstyle";
        #}
      ];
      language-server.nixd = {
        config.nixd.options = {
          nixos.expr = "(import ./nilla.nix).systems.nixos.${osConfig.networking.hostName}.result.options";
          home-manager.expr = "(import ./nilla.nix).systems.nixos.${osConfig.networking.hostName}.result.options.home-manager.users.type.getSubOptions []";
        };
      };
    };
  };
}
