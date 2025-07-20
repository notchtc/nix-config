{ lib, pkgs, ... }:
{
  environment = {
    localBinInPath = true;

    shells = [ pkgs.fish ];

    systemPackages = lib.attrValues { inherit (pkgs.fishPlugins) tide; };
  };
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;

    shellAliases = with pkgs; {
      e = "$EDITOR";
      cat = "${lib.getExe bat} -Pp";
      ls = "${lib.getExe eza} --classify=auto --group-directories-first";
    };

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
    '';
  };
}
