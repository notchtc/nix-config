{ config, pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    ediff = false;

    settings = {
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
        editor = config.home.sessionVariables.EDITOR;
        default-command = "log";
        diff-editor = ":builtin";
        pager = [ "${pkgs.moor}/bin/moor" ];
      };
    };
  };
}
