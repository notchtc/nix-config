{ lib, pkgs, ... }:
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

    systemPackages = lib.attrValues {
      inherit (pkgs.fishPlugins)
        async-prompt
        pure
        ;
    };
  };
  users.defaultUserShell = pkgs.fish;

  programs = {
    bat.enable = true;
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

      promptInit = ''
        set -g async_prompt_functions _pure_prompt_git

        set --universal pure_check_for_new_release false
        set --universal pure_enable_single_line_prompt true
        set --universal pure_enable_nixdevshell true
        set --universal pure_symbol_prompt λ
        set --universal pure_symbol_reverse_prompt Λ
        set --universal pure_shorten_prompt_current_directory_length 5
        set --universal pure_truncate_prompt_current_directory_keeps 6
      '';

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
  };
}
