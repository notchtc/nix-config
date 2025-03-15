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
        tide
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
        set --universal tide_character_icon λ
        set --universal tide_character_vi_icon_default Λ
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
