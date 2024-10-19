{ pkgs, ... }:
{
  imports = [ ./starship.nix ];

  environment.shells = [ pkgs.fish ];
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings
      zoxide init fish | source
    '';
  };
}
