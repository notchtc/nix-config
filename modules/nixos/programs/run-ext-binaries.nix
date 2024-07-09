{ pkgs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
