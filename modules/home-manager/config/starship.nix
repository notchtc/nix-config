{
  format = "$username$hostname$nix_shell$directory$character";
  right_format = "$git_branch$git_commit$git_state$git_status";
  add_newline = false;

  username = {
    format = "[$user]($style)";
  };

  hostname = {
    ssh_only = true;
    ssh_symbol = "";
    format = "@[$hostname]($style) ";
  };

  line_break.disabled = true;

  directory = {
    read_only = "(ro)";
  };

  git_commit.format = ''( [\($hash$tag\)]($style))'';
  git_state.format = " [\\($state( $progress_current/$progress_total)\\)]($style)";

  git_status = {
    ahead = "↑ ";
    behind = "↓ ";
    conflicted = "±";
    deleted = "×";
    diverged = "↕ ";
    modified = "‼";
    renamed = "≡";
    stashed = "⌂";
    format = ''( [\[$all_status$ahead_behind\]]($style))'';
  };

  git_branch = {
    format = "[$symbol$branch(:$remote_branch)]($style)";
    symbol = "";
  };

  nix_shell.format = "[(\\($name\\))]($style) ";
}
