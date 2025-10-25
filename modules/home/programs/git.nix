{ config, ... }:
let
  jj = config.programs.jujutsu.settings;
in
{
  programs.git = {
    enable = true;

    signing = {
      inherit (jj.signing) key;
      format = "ssh";
      signByDefault = true;
    };

    settings = {
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = true;
      help.autocorrect = "prompt";
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      pull.rebase = true;
      tag.sort = "version:refname";

      user = { inherit (jj.user) name email; };

      alias = {
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
  };
}
