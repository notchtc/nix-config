{ config, pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitMinimal;

      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };

      extraConfig = {
        branch.sort = "-committerdate";
        column.ui = "auto";
        commit.verbose = true;
        help.autocorrect = "prompt";
        init.defaultBranch = "main";
        merge.conflictstyle = "zdiff3";
        pull.rebase = true;
        tag.sort = "version:refname";

        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };

        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };

        push = {
          default = "simple";
          autoSetupRemote = true;
          followTags = true;
        };

        rebase = {
          autoSquash = true;
          autoStash = true;
          updateRefs = true;
        };
      };

      aliases = {
        d = "diff";
        a = "add";
        p = "push";
        r = "rebase";
        ri = "rebase -i";
        cm = "commit";
        pl = "pull";
        s = "status";
        st = "stash";
        ck = "checkout";
        rl = "reflog";
      };

      difftastic = {
        enable = true;
        background = "dark";
      };
    };

    jujutsu = {
      inherit (config.programs.git) enable;

      settings = {
        user = {
          name = config.programs.git.userName;
          email = config.programs.git.userEmail;
        };

        aliases = {
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
          sign-on-push = true;

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
          behavior = "drop";
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
  };
}
