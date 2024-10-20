{ pkgs, ... }:
{
  imports = [ ./starship.nix ];

  environment.shells = [ pkgs.fish ];
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
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
}
