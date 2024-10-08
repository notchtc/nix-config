{
  programs = {
    git = {
      enable = true;
      userName = "chtc";
      userEmail = "chtc@tuta.io";

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
  };
}
