{
  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$nix_shell$directory$character";
      right_format = "$git_branch$git_commit$git_state$git_status";
      add_newline = false;
      line_break.disabled = true;

      directory.read_only = " (r)";
      git_commit.format = ''( [\($hash$tag\)]($style))'';
      git_state.format = " [\\($state( $progress_current/$progress_total)\\)]($style)";
      nix_shell.format = "[(\\($name\\))]($style) ";
      username.format = "[$user]($style) ";

      hostname = {
        ssh_only = true;
        ssh_symbol = "";
        format = "at [$hostname]($style) ";
      };

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

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
        vimcmd_symbol = "[Λ](bold white)";
        vimcmd_replace_one_symbol = "[Λ](bold purple)";
        vimcmd_replace_symbol = "[Λ](bold_purple)";
        vimcmd_visual_symbol = "[Λ](bold_yellow)";
      };
    };
  };
}
