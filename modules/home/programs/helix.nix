{ osConfig, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs.evil-helix;

    extraPackages = builtins.attrValues { inherit (pkgs) markdown-oxide nixd nixfmt; };
    settings = {
      theme = "base16_transparent";
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
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.nixfmt}/bin/nixfmt";
            args = [ "-s" ];
          };
        }
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
