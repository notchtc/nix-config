{ pkgs, ... }:
{
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
  };
}
