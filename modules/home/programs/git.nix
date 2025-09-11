{ pkgs, ... }:
{
  programs.git = {
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
}
