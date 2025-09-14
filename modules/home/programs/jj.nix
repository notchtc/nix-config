{ config, ... }:
{
  programs.jujutsu = {
    inherit (config.programs.git) enable;

    settings = {
      user = {
        name = config.programs.git.userName;
        email = config.programs.git.userEmail;
      };

      aliases = {
        e = [ "edit" ];
        d = [ "describe" ];
        df = [ "diff" ];
        l = [ "log" ];
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
        inherit (config.programs.git.signing) key;
      };

      template-aliases = {
        "format_timestamp(timestamp)" = "timestamp.ago()";
      };

      ui = {
        default-command = "status";
        editor = config.home.sessionVariables.EDITOR;
        diff-editor = ":builtin";
        diff-formatter = [
          "difft"
          "--color=always"
          "$left"
          "$right"
        ];
      };
    };
  };
}
