{ config, pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;

    settings = {
      aliases = {
        e = [ "edit" ];
        d = [ "describe" ];
        df = [ "diff" ];
        l = [ "log" ];
        n = [ "new" ];
        s = [ "show" ];
        sq = [ "squash" ];
        gp = [
          "git"
          "push"
        ];
        tug = [
          "util"
          "exec"
          "--"
          "sh"
          "-c"
          ''
            if [ "x$1" = "x" ]; then
              jj bookmark move --from "closest_bookmark(@)" --to "closest_pushable(@)"
            else
              jj bookmark move --to "closest_pushable(@)" "$@"
            fi
          ''
          ""
        ];
      };

      git = {
        fetch = [
          "upstream"
          "origin"
        ];
        push = "origin";
      };

      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
        "closest_pushable(to)" =
          "heads(::to & mutable() & ~description(exact:\"\") & (~empty() | merges()))";
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
        editor = config.home.sessionVariables.EDITOR;
        default-command = "log";
        diff-editor = ":builtin";
        pager = [ "${pkgs.moor}/bin/moor" ];
      };
    };
  };
}
