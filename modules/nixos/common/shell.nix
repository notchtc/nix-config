{ pkgs, ... }:
{
  environment = {
    localBinInPath = true;

    shells = [ pkgs.fish ];
    shellAliases = {
      e = "$EDITOR";
      se = "doas $EDITOR";
      cat = "bat";
      ls = "eza";
    };
  };
  users.defaultUserShell = pkgs.fish;

  programs = {
    command-not-found.enable = false;
    git.enable = true;
    gnupg.agent.enable = true;
    nano.enable = false;
    nix-index-database.comma.enable = true;
    bash.shellInit = ''
      export HISTFILE="$XDG_STATE_HOME"/bash/history
    '';

    vim = {
      enable = true;
      defaultEditor = true;
    };

    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        set fish_cursor_default block blink
        set fish_cursor_insert line blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_replace underscore blink
        set fish_cursor_external line blink
        set fish_cursor_visual block blink
        fish_vi_key_bindings
        zoxide init fish | source
      '';
    };

    starship = {
      enable = true;
      settings = {
        format = "$username$hostname$nix_shell$directory$character";
        right_format = "$git_branch$git_commit$git_state$git_status";
        add_newline = false;
        line_break.disabled = true;

        git_commit.format = ''( [\($hash$tag\)]($style))'';
        git_state.format = " [\\($state( $progress_current/$progress_total)\\)]($style)";
        nix_shell.format = "[(\\($name\\))]($style) ";
        username.format = "[$user]($style) ";

        hostname = {
          ssh_only = true;
          ssh_symbol = "";
          format = "at [$hostname]($style) ";
        };

        directory = {
          read_only = " (r)";
          fish_style_pwd_dir_length = 5;
        };

        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
          vimcmd_symbol = "[Λ](bold white)";
          vimcmd_replace_one_symbol = "[Λ](bold purple)";
          vimcmd_replace_symbol = "[Λ](bold_purple)";
          vimcmd_visual_symbol = "[Λ](bold_yellow)";
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
      };
    };
  };
}
