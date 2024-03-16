{
  lib,
  pkgs,
  ...
}: {
  programs = {
    gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
      };

      extensions = lib.attrValues {
        inherit
          (pkgs)
          gh-cal
          gh-dash
          gh-eco
          gh-markdown-preview
          ;
      };
    };

    git = {
      enable = true;

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
