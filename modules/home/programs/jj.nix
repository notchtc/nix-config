{ config, pkgs, ... }:
let
  delta = "${pkgs.delta}/bin/delta";
in
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
        inherit (config.programs.git.signing) key;
      };

      template-aliases = {
        "format_timestamp(timestamp)" = "timestamp.ago()";
      };

      diff.tool = "delta";
      ui = {
        editor = config.home.sessionVariables.EDITOR;
        default-command = "log";
        diff-editor = ":builtin";
        diff-formatter = ":git";
        pager = [
          delta
          "--pager"
          "less -FRX"
        ];
      };

      "--scope" = [
        {
          "--when".commands = [
            "diff"
            "show"
          ];
          ui.pager = delta;
        }
      ];
    };
  };
}
