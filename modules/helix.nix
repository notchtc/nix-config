{
  config.modules.home.helix =
    { lib, pkgs, ... }:
    let
      inherit (lib.attrsets) attrValues genAttrs;
      inherit (lib.meta) getExe;
      inherit (lib.trivial) const flip;
    in
    {
      environment.sessionVariables.EDITOR = getExe pkgs.helix;

      packages = attrValues {
        inherit (pkgs)
          helix
          markdown-oxide
          nixd
          nixfmt
          ;
      };

      xdg = {
        mime-apps.default-applications = flip genAttrs (const "Helix.desktop") [
          "application/x-shellscript"
          "text/csv"
          "text/english"
          "text/plain"
        ];

        config.files = {
          "helix/config.toml" = {
            generator = pkgs.writers.writeTOML "helix-config.toml";
            value = {
              theme = "gruvbox_dark_hard";
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
          };

          "helix/languages.toml" = {
            generator = pkgs.writers.writeTOML "helix-languages.toml";
            value = {
              language = [
                {
                  name = "nix";
                  auto-format = true;
                  formatter = {
                    command = "nixfmt";
                    args = [ "-s" ];
                  };
                }
              ];
            };
          };
        };
      };
    };
}
