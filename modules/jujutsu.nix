{
  config.modules.home.jujutsu =
    { lib, pkgs, ... }:
    let
      inherit (lib.meta) getExe;
    in
    {
      packages = [ pkgs.jujutsu ];

      xdg.config.files."jj/config.toml" = {
        generator = pkgs.writers.writeTOML "jj-config.toml";
        value = {
          user = {
            email = "chtc@tuta.io";
            name = "chtc";
          };

          aliases = {
            ba = [
              "bookmark"
              "advance"
            ];
            d = [ "describe" ];
            df = [ "diff" ];
            e = [ "edit" ];
            l = [ "log" ];
            n = [ "new" ];
            s = [ "show" ];
            sq = [ "squash" ];
            gp = [
              "git"
              "push"
            ];
          };

          git = {
            sign-on-push = true;

            fetch = [
              "upstream"
              "origin"
            ];
            push = "origin";
          };

          remotes.origin = {
            auto-track-bookmarks = "glob:*";
            push-new-bookmarks = true;
          };

          signing = {
            behavior = "own";
            backend = "ssh";
            key = "~/.ssh/id_ed25519.pub";
          };

          template-aliases = {
            "format_timestamp(timestamp)" = "timestamp.ago()";
          };

          ui = {
            default-command = [
              "log"
              "-s"
            ];
            diff-editor = ":builtin";
            diff-formatter = [
              "${getExe pkgs.difftastic}"
              "--color=always"
              "--sort-paths"
              "$left"
              "$right"
            ];
            pager = [ "${getExe pkgs.moor}" ];
          };
        };
      };
    };
}
