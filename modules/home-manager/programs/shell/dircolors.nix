{ pkgs, ... }:
{
  programs = {
    dircolors = {
      enable = true;

      extraConfig = builtins.readFile (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/a283d79dcbb23a8679f4b1a07d04a80cab01c0ba/LS_COLORS";
          hash = "sha256-bUj/EBc6DZ/UH4dim968BGgo8KYn+z436Oz4N9HeN6k=";
        }
      );
    };
  };
}
