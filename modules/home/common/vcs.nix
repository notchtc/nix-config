{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.watchman ];

  programs = {
    git = {
      enable = true;
      userName = "chtc";
      userEmail = "chtc@tuta.io";

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
        core.fsmonitor = "watchman";

        user = {
          name = config.programs.git.userName;
          email = config.programs.git.userEmail;
        };

        aliases = {
          d = [ "diff" ];
          l = [ "log" ];
          gp = [
            "git"
            "push"
          ];
        };

        git = {
          fetch = [
            "upstream"
            "origin"
          ];
          push = "origin";
        };

        signing = {
          behavior = "own";
          backend = "ssh";
          inherit (config.programs.git.signing) key;
        };

        ui = {
          default-command = "status";
          editor = config.home.sessionVariables.EDITOR;
          diff-formatter = [
            "${lib.getExe pkgs.difftastic}"
            "--color=always"
            "$left"
            "$right"
          ];
        };
      };
    };
  };
}
